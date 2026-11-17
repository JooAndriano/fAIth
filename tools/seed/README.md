# tools/seed — seed renungan ke Firestore

Membaca `content/devotionals/*.json`, mengambil **hanya** yang `"status": "published"`, lalu menulis
ke koleksi `devotionals` di Firestore memakai Firebase Admin SDK.

- **Target default:** project `faith-514ef`, database `(default)`, koleksi `devotionals`.
- **Idempotent:** ID dokumen = `day-NNN` dari `dayNumber` (sama dengan id di app, mis. `day-001`).
  Dokumen yang isinya sudah sama **tidak ditulis ulang** (hemat kuota). `createdAt` hanya diisi saat
  dokumen pertama kali dibuat; `updatedAt` diperbarui saat isinya berubah. Aman dijalankan berulang.
- **Validasi dulu, tulis kemudian:** kalau satu file saja tidak valid (field kurang, `verseRef` salah
  format, `dayNumber` dobel, `id` tidak cocok dengan `dayNumber`), tidak ada yang ditulis sama sekali.
- **Draft tidak pernah ditulis.** Kalau sebuah renungan diubah dari `published` ke `draft`, dokumen lama
  di Firestore **tidak dihapus** otomatis — skrip hanya memberi peringatan. Hapus manual di Console.
- Semua penulisan dalam satu batch (atomik, maks. 500 dokumen).

## Persiapan (sekali saja)

```powershell
cd D:\PROJECT\fAIth\tools\seed
npm install
npm test
```

Butuh Node.js 20+.

## Kredensial

Skrip **hanya** membaca kredensial dari variabel lingkungan `GOOGLE_APPLICATION_CREDENTIALS`.
Jangan pernah menaruh file key di dalam repo — skrip akan **menolak** jalan bila key berada di dalam
folder repo, dan juga menolak bila `project_id` di key berbeda dengan `--project`.

1. Firebase Console → project **faith-514ef** → ⚙ Project settings → **Service accounts** →
   **Generate new private key**.
2. Simpan di luar repo, misalnya `C:\Users\<kamu>\.secrets\faith-514ef-seed.json`.
3. Set variabel untuk sesi PowerShell saat ini saja:

   ```powershell
   $env:GOOGLE_APPLICATION_CREDENTIALS = "C:\Users\<kamu>\.secrets\faith-514ef-seed.json"
   ```

Mode `--dry-run` dan `--emulator` tidak butuh kredensial.

## Pemakaian

```text
node seed-devotionals.mjs (--project <id> | --emulator) [opsi]

  --project <id>        Project Firebase tujuan (mis. faith-514ef)
  --emulator            Tulis ke Firestore emulator (FIRESTORE_EMULATOR_HOST atau 127.0.0.1:8080)
  --dry-run             Hanya cetak apa yang akan ditulis; tidak konek ke Firebase sama sekali
  --database <id>       ID database Firestore (default: "(default)")
  --collection <name>   Koleksi tujuan (default: devotionals)
  --dir <path>          Folder sumber (default: content/devotionals)
```

Contoh (PowerShell, dari `tools\seed`):

```powershell
# 1. Lihat dulu apa yang akan ditulis
node seed-devotionals.mjs --project faith-514ef --dry-run

# 2. Uji ke emulator (jalankan `firebase emulators:start --only firestore` di terminal lain)
node seed-devotionals.mjs --emulator

# 3. Tulis sungguhan
$env:GOOGLE_APPLICATION_CREDENTIALS = "C:\Users\<kamu>\.secrets\faith-514ef-seed.json"
node seed-devotionals.mjs --project faith-514ef
Remove-Item Env:GOOGLE_APPLICATION_CREDENTIALS
```

## Format file renungan

Satu file JSON per hari, mis. `content/devotionals/day-001.json`:

```json
{
  "id": "day-001",
  "dayNumber": 1,
  "title": "…",
  "verseRef": "JHN:14:27",
  "verseText": "… (dari aset Alkitab AYT, bukan tulisan AI) …",
  "body": "…",
  "reflectionQuestions": ["…", "…"],
  "prayer": "…",
  "tags": ["…"],
  "status": "draft"
}
```

- `id` opsional; kalau ada harus sama dengan `day-NNN` dari `dayNumber`.
- `verseRef` format `BUKU:pasal:ayat[-ayatAkhir]` dengan kode buku seperti di app (`PSA`, `1JN`, `PHP`).
- `status`: `draft` atau `published`. Ubah ke `published` hanya setelah direview manual.
- `verseText` yang masih diawali `[CONTOH]` memicu peringatan (placeholder belum diganti teks AYT).
