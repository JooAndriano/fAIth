const DEFAULT_DAILY_LIMIT = 30;
const TTL_SECONDS = 2 * 24 * 60 * 60;
// The day is computed in WIB (UTC+7) so quotas reset at midnight Indonesian time.
const DAY_OFFSET_MS = 7 * 60 * 60 * 1000;

/** YYYY-MM-DD in WIB (UTC+7). */
export function dayKey(now: Date = new Date()): string {
  return new Date(now.getTime() + DAY_OFFSET_MS).toISOString().slice(0, 10);
}

export function parseLimit(raw: string | undefined): number {
  const n = Number.parseInt(raw ?? '', 10);
  return Number.isFinite(n) && n > 0 ? n : DEFAULT_DAILY_LIMIT;
}

export interface RateLimitResult {
  allowed: boolean;
  count: number;
  limit: number;
}

/** Minimal KV surface used here (keeps this module testable without Workers types). */
export interface CounterStore {
  get(key: string): Promise<string | null>;
  put(key: string, value: string, options?: { expirationTtl?: number }): Promise<void>;
}

/**
 * Counts one request for `uid` today. Returns allowed=false (without incrementing)
 * once the daily limit is reached.
 *
 * KV is eventually consistent and has no atomic increment, so concurrent requests
 * can slightly exceed the limit. Acceptable for a soft per-user daily quota.
 */
export async function consumeDailyQuota(
  kv: CounterStore,
  uid: string,
  limit: number,
  now: Date = new Date(),
): Promise<RateLimitResult> {
  const key = `rl:${uid}:${dayKey(now)}`;
  const current = Number.parseInt((await kv.get(key)) ?? '0', 10) || 0;
  if (current >= limit) {
    return { allowed: false, count: current, limit };
  }
  const next = current + 1;
  await kv.put(key, String(next), { expirationTtl: TTL_SECONDS });
  return { allowed: true, count: next, limit };
}
