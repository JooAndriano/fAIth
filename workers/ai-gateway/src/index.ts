import { bearerToken, verifyFirebaseIdToken } from './auth.ts';
import { systemPromptFor } from './prompts.ts';
import { generateText, ProviderError } from './provider.ts';
import { consumeDailyQuota, parseLimit } from './ratelimit.ts';
import type { Env } from './types.ts';
import { validateGenerateRequest } from './validate.ts';

const MAX_BODY_CHARS = 64 * 1024;

function json(data: unknown, status = 200, headers: Record<string, string> = {}): Response {
  return new Response(JSON.stringify(data), {
    status,
    headers: { 'Content-Type': 'application/json; charset=utf-8', ...headers },
  });
}

function error(status: number, message: string, headers: Record<string, string> = {}): Response {
  return json({ error: message }, status, headers);
}

async function handleGenerate(request: Request, env: Env): Promise<Response> {
  // 1. Auth
  const token = bearerToken(request.headers.get('Authorization'));
  if (!token) return error(401, 'Silakan masuk terlebih dahulu.');
  let uid: string;
  try {
    uid = await verifyFirebaseIdToken(token, env.FIREBASE_PROJECT_ID);
  } catch {
    return error(401, 'Sesi tidak valid. Silakan masuk kembali.');
  }

  // 2. Input
  const raw = await request.text();
  if (raw.length > MAX_BODY_CHARS) return error(400, 'Permintaan terlalu besar.');
  let body: unknown;
  try {
    body = JSON.parse(raw);
  } catch {
    return error(400, 'Body harus berupa JSON yang valid.');
  }
  const parsed = validateGenerateRequest(body);
  if (!parsed.ok) return error(400, parsed.error);

  // 3. Rate limit (after validation, so malformed requests don't use up the quota)
  const quota = await consumeDailyQuota(env.RATE_KV, uid, parseLimit(env.DAILY_LIMIT_CHAT));
  if (!quota.allowed) {
    return error(
      429,
      'Kamu sudah mencapai batas percakapan untuk hari ini. Istirahat sejenak, ' +
        'dan mari lanjutkan lagi besok. Tuhan memberkati.',
    );
  }

  // 4. Provider. Never forward provider details to the client.
  const { mode, messages } = parsed.value;
  try {
    const text = await generateText(env, systemPromptFor(mode), messages);
    return json({ text });
  } catch (e) {
    const detail = e instanceof ProviderError ? e.detail : 'unexpected';
    console.error(`generate failed: mode=${mode} ${detail}`);
    return error(502, 'Maaf, layanan sedang mengalami gangguan. Silakan coba lagi nanti.');
  }
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const { pathname } = new URL(request.url);

    if (pathname === '/health') {
      if (request.method !== 'GET') return error(405, 'Method not allowed', { Allow: 'GET' });
      return json({ ok: true });
    }

    if (pathname === '/v1/generate') {
      if (request.method !== 'POST') return error(405, 'Method not allowed', { Allow: 'POST' });
      try {
        return await handleGenerate(request, env);
      } catch (e) {
        console.error(`unhandled: ${e instanceof Error ? e.name : 'unknown'}`);
        return error(500, 'Terjadi kesalahan. Silakan coba lagi nanti.');
      }
    }

    return error(404, 'Not found');
  },
} satisfies ExportedHandler<Env>;
