# faith-ai-gateway

Cloudflare Worker yang menjadi gateway antara aplikasi fAIth (Flutter) dan penyedia AI
(saat ini Torcons, kompatibel OpenAI). Klien tidak pernah memegang API key penyedia.

## Endpoint

| Method | Path           | Keterangan                                                                 |
| ------ | -------------- | -------------------------------------------------------------------------- |
| GET    | `/health`      | `{"ok":true}`                                                              |
| POST   | `/v1/generate` | Body `{"mode":"chat"\|"devotional","messages":[{"role":"user"\|"assistant","text":"..."}]}` → `{"text":"..."}` |

`/v1/generate` butuh header `Authorization: Bearer <Firebase ID token>` (project `faith-514ef`).

| Status | Arti                                                                 |
| ------ | -------------------------------------------------------------------- |
| 400    | Input tidak valid (maks. 20 pesan, maks. 2000 karakter per pesan)    |
| 401    | Token tidak ada / tidak valid / kedaluwarsa                          |
| 429    | Kuota harian per pengguna habis (`DAILY_LIMIT_CHAT`, reset 00:00 WIB) |
| 502    | Penyedia AI gagal (detail hanya di log Worker)                       |

Error selalu berbentuk `{"error":"<pesan Bahasa Indonesia>"}`.

## Struktur

```
src/index.ts      routing + alur: auth → validasi → rate limit → provider
src/auth.ts       verifikasi Firebase ID token (jose, JWKS Google)
src/validate.ts   validasi body
src/ratelimit.ts  kuota harian di KV: rl:{uid}:{YYYY-MM-DD}, TTL 2 hari
src/prompts.ts    system prompt per mode
src/provider.ts   SATU-SATUNYA tempat memanggil penyedia AI: generateText(env, systemPrompt, messages)
```

Ganti penyedia (mis. Gemini) cukup dengan mengubah `src/provider.ts`.

## Setup

```sh
cd workers/ai-gateway
npm install

# KV untuk rate limit, lalu salin id ke wrangler.toml
npx wrangler kv namespace create RATE_KV
npx wrangler kv namespace create RATE_KV --preview

# Isi TORCONS_MODEL di wrangler.toml, lalu simpan API key sebagai secret (jangan di-commit)
npx wrangler secret put TORCONS_API_KEY
```

## Dev, test, deploy

```sh
cp .dev.vars.example .dev.vars   # isi TORCONS_API_KEY untuk lokal (.dev.vars di-gitignore)
npm run dev                      # http://localhost:8787
npm test                         # unit test (node --test, Node 22+)
npm run typecheck
npm run deploy
```

## Contoh curl

```sh
# Health
curl http://localhost:8787/health
# -> {"ok":true}

# Tanpa token -> 401
curl -i -X POST http://localhost:8787/v1/generate \
  -H "Content-Type: application/json" \
  -d '{"mode":"chat","messages":[{"role":"user","text":"Halo"}]}'
# -> HTTP/1.1 401 ... {"error":"Silakan masuk terlebih dahulu."}

# Dengan token (ambil ID token dari app yang sudah login)
curl -X POST http://localhost:8787/v1/generate \
  -H "Authorization: Bearer $ID_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"mode":"chat","messages":[{"role":"user","text":"Saya sedang cemas soal pekerjaan."}]}'
```

Catatan: KV tidak punya increment atomik, jadi permintaan paralel bisa sedikit melewati batas.
Cukup untuk kuota lunak per pengguna.
