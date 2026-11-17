/**
 * The ONLY place that talks to the AI provider. To switch providers (e.g. Gemini),
 * reimplement `generateText` here; nothing else needs to change.
 *
 * Current provider: Torcons (OpenAI-compatible chat completions, no streaming).
 */
import type { ChatMessage, Env } from './types.ts';

const TIMEOUT_MS = 25_000;
const MAX_TOKENS = 800;

/** Provider failure. `detail` is for logs only and must never be sent to the client. */
export class ProviderError extends Error {
  readonly detail: string;

  constructor(detail: string) {
    super('provider_error');
    this.name = 'ProviderError';
    this.detail = detail;
  }
}

interface ChatCompletionResponse {
  choices?: { message?: { content?: unknown } }[];
}

export async function generateText(
  env: Pick<Env, 'TORCONS_BASE_URL' | 'TORCONS_MODEL' | 'TORCONS_API_KEY'>,
  systemPrompt: string,
  messages: ChatMessage[],
): Promise<string> {
  const url = `${env.TORCONS_BASE_URL.replace(/\/+$/, '')}/v1/chat/completions`;
  const body = {
    model: env.TORCONS_MODEL,
    messages: [
      { role: 'system', content: systemPrompt },
      ...messages.map((m) => ({ role: m.role, content: m.text })),
    ],
    max_tokens: MAX_TOKENS,
  };

  let res: Response;
  try {
    res = await fetch(url, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${env.TORCONS_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
      signal: AbortSignal.timeout(TIMEOUT_MS),
    });
  } catch (e) {
    const name = e instanceof Error ? e.name : 'unknown';
    throw new ProviderError(name === 'TimeoutError' ? 'timeout' : `fetch failed: ${name}`);
  }

  if (!res.ok) {
    throw new ProviderError(`http ${res.status}`);
  }

  let data: ChatCompletionResponse;
  try {
    data = (await res.json()) as ChatCompletionResponse;
  } catch {
    throw new ProviderError('invalid json');
  }

  const content = data.choices?.[0]?.message?.content;
  if (typeof content !== 'string' || content.trim().length === 0) {
    throw new ProviderError('empty content');
  }
  return content.trim();
}
