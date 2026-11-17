import type { ChatMessage, GenerateRequest, Mode } from './types.ts';

export const MAX_MESSAGES = 20;
export const MAX_TEXT_LENGTH = 2000;

const MODES: readonly string[] = ['chat', 'devotional'];
const ROLES: readonly string[] = ['user', 'assistant'];

export type ValidationResult =
  | { ok: true; value: GenerateRequest }
  | { ok: false; error: string };

/** Validates the parsed JSON body of POST /v1/generate. */
export function validateGenerateRequest(body: unknown): ValidationResult {
  if (typeof body !== 'object' || body === null || Array.isArray(body)) {
    return { ok: false, error: 'Body harus berupa objek JSON.' };
  }
  const { mode, messages } = body as Record<string, unknown>;

  if (typeof mode !== 'string' || !MODES.includes(mode)) {
    return { ok: false, error: 'Mode tidak dikenal.' };
  }
  if (!Array.isArray(messages) || messages.length === 0) {
    return { ok: false, error: 'Pesan tidak boleh kosong.' };
  }
  if (messages.length > MAX_MESSAGES) {
    return { ok: false, error: `Maksimal ${MAX_MESSAGES} pesan.` };
  }

  const clean: ChatMessage[] = [];
  for (const m of messages) {
    if (typeof m !== 'object' || m === null) {
      return { ok: false, error: 'Format pesan tidak valid.' };
    }
    const { role, text } = m as Record<string, unknown>;
    if (typeof role !== 'string' || !ROLES.includes(role)) {
      return { ok: false, error: 'Peran pesan tidak valid.' };
    }
    if (typeof text !== 'string' || text.trim().length === 0) {
      return { ok: false, error: 'Teks pesan tidak boleh kosong.' };
    }
    if (text.length > MAX_TEXT_LENGTH) {
      return { ok: false, error: `Maksimal ${MAX_TEXT_LENGTH} karakter per pesan.` };
    }
    clean.push({ role: role as ChatMessage['role'], text });
  }

  return { ok: true, value: { mode: mode as Mode, messages: clean } };
}
