export interface Env {
  FIREBASE_PROJECT_ID: string;
  TORCONS_BASE_URL: string;
  TORCONS_MODEL: string;
  DAILY_LIMIT_CHAT?: string;
  TORCONS_API_KEY: string; // secret: `wrangler secret put TORCONS_API_KEY`
  RATE_KV: KVNamespace;
}

export type Mode = 'chat' | 'devotional';

export interface ChatMessage {
  role: 'user' | 'assistant';
  text: string;
}

export interface GenerateRequest {
  mode: Mode;
  messages: ChatMessage[];
}
