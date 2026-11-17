# Firestore

Project: **faith-514ef** (`.firebaserc`), database `(default)`. Konfigurasi CLI ada di `firebase.json`
(rules: `firestore.rules`, indexes: `firestore.indexes.json`). Region database: asia-southeast2
(perlu dicek di Console).

## Koleksi

Status "dipakai" = dibaca/ditulis oleh kode saat ini.

| Koleksi | Akses (rules) | Dipakai? | Field |
|---|---|---|---|
| `users/{uid}` | baca/tulis hanya pemilik (`userId == auth.uid`, `uid` == auth.uid); delete ditolak | **ya**, oleh `AuthService.syncUserProfile` | `uid, email, displayName, photoUrl, favoriteVerse?, language ('id'), darkMode (false), dailyMessages (5), usedMessages (0), createdAt, updatedAt` |
| `devotionals/{day-NNN}` | **tidak ada rule** (kena default deny) | ditulis oleh `tools/seed` | `id, dayNumber, title, verseRef, verseText, body, reflectionQuestions[], prayer, tags[], status, createdAt, updatedAt` |
| `prayers/{id}` | pemilik via field `uid` | belum | rencana: `uid, title?, body, tags[], isAnswered, answeredAt?, createdAt, updatedAt` |
| `chat_history/{id}` | pemilik via field `uid` | belum | rencana: `uid, title?, lastMessage?, messageCount, createdAt, updatedAt` (pesan di subkoleksi `messages`) |
| `saved_devotionals/{id}` | pemilik via field `uid` | belum | rencana: `uid, devotionalId, note?, createdAt` |
| `favorite_verses/{id}` | pemilik via field `uid` | belum | rencana: `uid`, ref ayat + kode terjemahan (bukan teks) |
| `daily_devotionals/{id}` | publik baca, tulis ditolak | belum | skema lama, kemungkinan digantikan `devotionals` (perlu dicek) |
| `featured_studies`, `reading_plans`, `topics` | publik baca, tulis ditolak | belum | rencana |
| lainnya | default deny | — | — |

Kolom "rencana" diambil dari skema v1 lama dan belum diverifikasi terhadap layar yang ada.
Skema final perlu diaudit sebelum repository Firestore dibuat (lihat `docs/PLAN.md`).

## Rules (`firestore.rules`)

- Data privat: pemilik ditentukan oleh field `uid` di dokumen (`resource.data.uid` /
  `request.resource.data.uid`), kecuali `users`, yang memakai ID dokumen.
- Konten publik: hanya bisa dibaca, dan ditulis lewat Admin SDK (seed).
- Default: semua ditolak.
- **Belum ada rules test dan konfigurasi emulator** di `firebase.json`. Perubahan rules wajib disertai
  rules test begitu infrastrukturnya ada.

### Masalah yang diketahui (perlu diperbaiki, belum diubah)
1. Seed menulis ke `devotionals`, tetapi rules hanya membuka `daily_devotionals`, sehingga app belum bisa
   membaca renungan hasil seed.
2. Rules `users` membolehkan klien menulis `dailyMessages`/`usedMessages` (kuota). Seharusnya
   field ini tidak bisa ditulis klien. Nilai default `dailyMessages: 5` juga berbeda dengan keputusan
   25 pesan/hari (lihat `docs/DECISIONS.md`).

## Indexes (`firestore.indexes.json`)

Composite, scope COLLECTION:
- `prayers`: `uid` ASC, `createdAt` DESC
- `chat_history`: `uid` ASC, `updatedAt` DESC
- `saved_devotionals`: `uid` ASC, `createdAt` DESC

## Deploy

```sh
firebase deploy --only firestore:rules --project faith-514ef
firebase deploy --only firestore:indexes --project faith-514ef
```

## Seed renungan (`tools/seed`)

Sumber: `content/devotionals/day-NNN.json`. Yang ditulis **hanya** yang berstatus `"published"`,
dengan ID dokumen `day-NNN`. Skrip ini idempotent (dokumen yang tidak berubah dilewati), memvalidasi
semua file dulu sebelum menulis (gagal satu, batal semua), dan menulis semuanya dalam satu batch.
Draft tidak pernah ditulis atau dihapus.

```sh
cd tools/seed
npm install && npm test
node seed-devotionals.mjs --project faith-514ef --dry-run   # tanpa koneksi
node seed-devotionals.mjs --emulator                         # FIRESTORE_EMULATOR_HOST / 127.0.0.1:8080
node seed-devotionals.mjs --project faith-514ef              # sungguhan
```

Opsi lain: `--database <id>`, `--collection <name>` (default `devotionals`), `--dir <path>`.
Kredensial **hanya** lewat `GOOGLE_APPLICATION_CREDENTIALS` yang menunjuk ke key di **luar** repo.
Skrip menolak key yang berada di dalam repo atau yang `project_id`-nya tidak cocok. Detail lengkap ada
di `tools/seed/README.md`.

Emulator: `firebase emulators:start --only firestore` butuh Java 21 (perlu dicek di mesin dev).
