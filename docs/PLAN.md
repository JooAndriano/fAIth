# Rencana kerja

Status diverifikasi dari kode per 2026-11-17.

## Sedang dikerjakan
- Restrukturisasi repo: app Flutter dipindah ke root, prototipe web dan sistem dokumen lama dihapus,
  dokumentasi diganti `CLAUDE.md` + `docs/`.

## Berikutnya
- Melanjutkan Fase 2: layar statis Tanya fAIth (chat). `ChatRepository` (interface + Mock dengan
  paginasi 20, cursor) belum ada dan perlu dibuat dulu. Repo Doa (`PrayerRepository`) juga belum ada.

## Fase 1: Setup & cleanup
- [x] Proyek Flutter (Android + iOS), GetX, lint (`analysis_options.yaml`)
- [x] Firebase project faith-514ef, `firebase_options.dart`, `google-services.json`
- [x] Login Google + sinkronisasi `users/{uid}`
- [x] `firestore.rules` + `firestore.indexes.json` (skema awal)
- [x] Navigasi: splash, login, shell 5 tab, middleware auth, halaman 404
- [x] Design system dasar (tema, warna, tipografi, widget inti)

## Fase 2: UI statis (data Mock)
- [x] Fondasi UI: `FaithColors`, widget bersama, `ViewState`, rute + placeholder
- [x] Beranda (sapaan, ayat penguat, ayat hari ini, renungan hari ini, gereja terdekat)
- [ ] Tanya fAIth (chat)
- [ ] Renungan: daftar/detail + tersimpan
- [ ] Alkitab: tab, pembaca, pemilih terjemahan, tandai ayat
- [ ] Jurnal doa
- [ ] Ayat favorit (CRUD)
- [ ] Pengaturan, preferensi, profil + logout (halaman profil dasar sudah ada; perlu dicek
      kelengkapannya)
- [ ] Gereja terdekat
- [ ] Polish: transisi, state kosong/error, widget test

## Fase 3: Integrasi Firestore
- [x] Skrip seed renungan (`tools/seed`, Admin SDK, idempotent, hanya published)
- [ ] Audit skema final terhadap layar Fase 2
- [ ] Rules + rules test di emulator (pemilik saja, konten publik read-only, field kuota tidak bisa
      ditulis klien, validasi tipe/panjang), termasuk memperbaiki nama koleksi `devotionals`
- [ ] Repository Firestore: profil, renungan, favorit, doa (paginasi 20, tanpa listener di koleksi besar)
- [ ] Repository chat (riwayat dengan paginasi; balasan masih palsu)
- [ ] Pipeline Alkitab: asset JSON AYT/KJV/WEB + `BibleRepository` berbasis asset
- [ ] Skrip pembuatan konten renungan (bantuan AI, review manual)
- [ ] Deploy rules/indexes, seed 30 renungan yang sudah direview, uji e2e di perangkat

## Fase 4: Integrasi AI
- [ ] Cloudflare Worker sebagai gateway (API key, verifikasi token Firebase, rate limit)
- [ ] Gemini dengan respons streaming
- [ ] Kuota 25 pesan/user/hari
- [ ] Moderasi input/output

## Fase 5: Memori AI personal
- [ ] Penyimpanan dan pemakaian konteks personal user dalam percakapan

## Fase 6: Notifikasi & retensi
- [ ] FCM
- [ ] Pengingat harian (renungan/doa)
- [ ] Streak

## Fase 7: Polish & rilis
- [ ] i18n id/en
- [ ] Dark mode (tema sudah ada, `ThemeMode` masih dikunci light)
- [ ] Crash reporting
- [ ] Rilis Play Store
- [ ] SHA-1 Play App Signing didaftarkan ke Firebase
