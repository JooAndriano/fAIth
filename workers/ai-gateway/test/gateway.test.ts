import assert from 'node:assert/strict';
import { afterEach, describe, it } from 'node:test';

import { bearerToken } from '../src/auth.ts';
import { generateText, ProviderError } from '../src/provider.ts';
import { consumeDailyQuota, dayKey, parseLimit } from '../src/ratelimit.ts';
import { validateGenerateRequest } from '../src/validate.ts';

describe('validateGenerateRequest', () => {
  const msg = (text = 'halo') => ({ role: 'user', text });

  it('accepts a valid request', () => {
    const r = validateGenerateRequest({ mode: 'chat', messages: [msg()] });
    assert.equal(r.ok, true);
  });

  it('rejects unknown mode, bad role, empty and oversized input', () => {
    assert.equal(validateGenerateRequest({ mode: 'x', messages: [msg()] }).ok, false);
    assert.equal(
      validateGenerateRequest({ mode: 'chat', messages: [{ role: 'system', text: 'a' }] }).ok,
      false,
    );
    assert.equal(validateGenerateRequest({ mode: 'chat', messages: [] }).ok, false);
    assert.equal(validateGenerateRequest({ mode: 'chat', messages: [msg('   ')] }).ok, false);
    assert.equal(validateGenerateRequest(null).ok, false);
  });

  it('enforces 20 messages and 2000 chars', () => {
    const twenty = Array.from({ length: 20 }, () => msg());
    assert.equal(validateGenerateRequest({ mode: 'chat', messages: twenty }).ok, true);
    assert.equal(
      validateGenerateRequest({ mode: 'chat', messages: [...twenty, msg()] }).ok,
      false,
    );
    assert.equal(
      validateGenerateRequest({ mode: 'chat', messages: [msg('a'.repeat(2000))] }).ok,
      true,
    );
    assert.equal(
      validateGenerateRequest({ mode: 'chat', messages: [msg('a'.repeat(2001))] }).ok,
      false,
    );
  });

  it('strips unknown fields from messages', () => {
    const r = validateGenerateRequest({
      mode: 'chat',
      messages: [{ role: 'user', text: 'hi', extra: 1 }],
    });
    assert.ok(r.ok);
    assert.deepEqual(r.value.messages, [{ role: 'user', text: 'hi' }]);
  });
});

describe('bearerToken', () => {
  it('parses the header', () => {
    assert.equal(bearerToken('Bearer abc.def'), 'abc.def');
    assert.equal(bearerToken('bearer abc'), 'abc');
    assert.equal(bearerToken(null), null);
    assert.equal(bearerToken('Basic abc'), null);
    assert.equal(bearerToken('Bearer '), null);
  });
});

describe('rate limit', () => {
  class FakeKv {
    data = new Map<string, string>();
    ttls = new Map<string, number | undefined>();
    async get(k: string) {
      return this.data.get(k) ?? null;
    }
    async put(k: string, v: string, o?: { expirationTtl?: number }) {
      this.data.set(k, v);
      this.ttls.set(k, o?.expirationTtl);
    }
  }

  it('uses WIB day keys', () => {
    assert.equal(dayKey(new Date('2026-11-17T16:59:00Z')), '2026-11-17');
    assert.equal(dayKey(new Date('2026-11-17T17:00:00Z')), '2026-11-18');
  });

  it('parses the limit with a default of 30', () => {
    assert.equal(parseLimit(undefined), 30);
    assert.equal(parseLimit('abc'), 30);
    assert.equal(parseLimit('0'), 30);
    assert.equal(parseLimit('5'), 5);
  });

  it('allows up to the limit then blocks', async () => {
    const kv = new FakeKv();
    const now = new Date('2026-11-17T03:00:00Z');
    for (let i = 1; i <= 3; i++) {
      const r = await consumeDailyQuota(kv, 'u1', 3, now);
      assert.equal(r.allowed, true);
      assert.equal(r.count, i);
    }
    assert.equal((await consumeDailyQuota(kv, 'u1', 3, now)).allowed, false);
    assert.equal(kv.data.get('rl:u1:2026-11-17'), '3');
    assert.equal(kv.ttls.get('rl:u1:2026-11-17'), 172800);
    // Other users are independent.
    assert.equal((await consumeDailyQuota(kv, 'u2', 3, now)).allowed, true);
  });
});

describe('generateText (Torcons)', () => {
  const realFetch = globalThis.fetch;
  afterEach(() => {
    globalThis.fetch = realFetch;
  });
  const env = { TORCONS_BASE_URL: 'https://p.test/', TORCONS_MODEL: 'm1', TORCONS_API_KEY: 'k' };

  it('sends an OpenAI-style request and returns the content', async () => {
    let captured: { url: string; init: RequestInit } | undefined;
    globalThis.fetch = (async (url: string, init: RequestInit) => {
      captured = { url, init };
      return Response.json({ choices: [{ message: { content: ' Shalom ' } }] });
    }) as typeof fetch;

    const text = await generateText(env, 'SYS', [
      { role: 'user', text: 'a' },
      { role: 'assistant', text: 'b' },
    ]);
    assert.equal(text, 'Shalom');
    assert.equal(captured?.url, 'https://p.test/v1/chat/completions');
    const headers = captured?.init.headers as Record<string, string>;
    assert.equal(headers.Authorization, 'Bearer k');
    assert.deepEqual(JSON.parse(captured?.init.body as string), {
      model: 'm1',
      messages: [
        { role: 'system', content: 'SYS' },
        { role: 'user', content: 'a' },
        { role: 'assistant', content: 'b' },
      ],
      max_tokens: 800,
    });
  });

  it('throws ProviderError on HTTP error and empty content', async () => {
    globalThis.fetch = (async () => new Response('secret detail', { status: 500 })) as typeof fetch;
    await assert.rejects(generateText(env, 's', [{ role: 'user', text: 'a' }]), ProviderError);

    globalThis.fetch = (async () => Response.json({ choices: [] })) as typeof fetch;
    await assert.rejects(generateText(env, 's', [{ role: 'user', text: 'a' }]), ProviderError);
  });
});
