# Rencana Pengembangan fAIth

Terakhir diperbarui: 2026-11-17

Aturan kerja: satu langkah = satu commit kecil (conventional commits), `flutter analyze` harus bersih
setiap langkah, kerja langsung di branch `develop`, jangan push tanpa izin. Rujukan:
`CLAUDE.md`, `docs/ARCHITECTURE.md`, `docs/FIRESTORE.md`, `docs/DECISIONS.md`.

## Sedang dikerjakan

**Fase 2: UI statis dengan data Mock.** Lanjut dari langkah 1 di bawah (Chat).

## Berikutnya

Selesaikan Fase 2, lalu Fase 3 (audit skema, rules + rules test, repository Firestore).

---

## Fase 1: Setup (SELESAI)

- [x] Proyek Flutter, struktur feature-first, GetX
- [x] Firebase project `faith-514ef` (akun profesional), Auth Google Sign-In berfungsi
- [x] Rules awal, navigasi 5 tab, middleware auth
- [x] Design system dasar
- [x] Restrukturisasi repo: app Flutter di root, web dan sistem lama dihapus, dokumentasi di `CLAUDE.md` + `docs/`

## Fase 2: UI statis dengan data Mock (SEDANG BERJALAN)

Satu layar = satu langkah = satu commit. Controller hanya bicara ke interface repository;
implementasi Mock di-bind di `lib/core/bindings/app_bindings.dart`.

- [x] Fondasi UI: `FaithColors`, widget bersama, `ViewState`
- [x] Beranda + test
- [ ] 1. Chat + `ChatRepository` (interface + Mock, paginasi cursor 20, balasan palsu)
- [ ] 2. Renungan: daftar, detail, tersimpan
- [ ] 3. Alkitab: tab, pembaca, pemilih terjemahan, tandai ayat
- [ ] 4. Doa + `PrayerRepository`
- [ ] 5. Ayat favorit (CRUD)
- [ ] 6. Gereja terdekat (daftar dummy; peta ditunda ke fase lain)
- [ ] 7. Pengaturan, profil, logout, dan layar Tentang (atribusi AYT-YLSA + teks lisensi)
- [ ] 8. Polish: transisi, state kosong/loading/error konsisten, widget test tiap layar

## Fase 3: Integrasi Firestore

Mengganti implementasi Mock dengan implementasi nyata. Hemat kuota: paginasi (limit 20), hindari
listener ke koleksi besar, offline persistence aktif.

- [x] Database Firestore `faith-514ef` dibuat
- [x] Skrip seed renungan: `tools/seed/seed-devotionals.mjs` (Admin SDK; `--project`, `--emulator`,
      `--dry-run`, `--database`, `--collection`, `--dir`; idempotent; hanya status `published`;
      key wajib di luar repo). Unit test di `tools/seed/lib.test.mjs`. Dokumentasi:
      `docs/FIRESTORE.md` bagian "Seed renungan" dan `tools/seed/README.md`
- [ ] Cek isi `devotionals` di `faith-514ef` (Firebase Console): apakah seed sungguhan sudah pernah
      dijalankan belum tercatat di repo. Saat ini baru `day-001` yang `published` (`day-002`–`004` draft)
- [ ] Rules belum membuka koleksi `devotionals` (rules masih memakai `daily_devotionals`), jadi app
      belum bisa membaca hasil seed. Lihat "Masalah yang diketahui" di `docs/FIRESTORE.md`
- [ ] Audit skema Firestore terhadap layar Fase 2 (koleksi kurang/berlebih)
- [ ] Rules + rules test di emulator (user hanya akses miliknya; konten umum read-only;
      field kuota tidak bisa diubah dari client; validasi tipe dan panjang field)
- [ ] Repository Firestore: profil user, renungan, favorit, jurnal doa
- [ ] Repository chat: simpan dan baca riwayat (paginasi), balasan masih palsu
- [ ] Pipeline Alkitab: konversi data AYT/KJV/WEB ke asset app, `BibleRepository`, favorit
      menyimpan referensi (kitab:pasal:ayat + kode terjemahan), bukan teks
- [ ] Skrip konten renungan (AI-assisted, output ke `content/devotionals/` untuk direview manual)
- [ ] Deploy rules + indexes, seed 30 renungan hasil review, uji end-to-end di device

## Fase 4: Integrasi AI

- [ ] Gateway di Cloudflare Worker (menyimpan API key Gemini, verifikasi token Firebase, rate limit)
- [ ] Chat nyata dengan streaming jawaban
- [ ] Kuota 25 pesan/user/hari, pesan ramah saat kuota habis
- [ ] Moderasi dan system prompt pendamping rohani (netral denominasi)
- [ ] Model cadangan bila kuota gratis penyedia habis

## Fase 5: Memori AI personal

- [ ] Ringkasan percakapan dan preferensi user (topik doa, ayat favorit)
- [ ] Penyimpanan ringkasan (Firestore atau KV/D1 Cloudflare, putuskan saat fase ini dimulai)
- [ ] Kontrol privasi: lihat dan hapus memori

## Fase 6: Notifikasi dan retensi

- [ ] FCM: renungan harian dan pengingat doa
- [ ] Streak dan pengingat ringan
- [ ] Penjadwalan (Cron Trigger Worker atau FCM scheduled)

## Fase 7: Polish dan rilis

- [ ] i18n id/en, dark mode dirapikan
- [ ] Crash reporting, App Check
- [ ] SHA-1 dari Play App Signing didaftarkan ke Firebase
- [ ] Budget alert bila pindah ke Blaze
- [ ] Persiapan Play Store (ikon, deskripsi, kebijakan privasi, atribusi lisensi)

---

## Utang teknis dan hal yang perlu dicek

- [ ] `firebase_options.dart`: semua platform harus `faith-514ef`; masih ada sisa `faith-jivottama`
      (web/iOS/macOS) dan `com.example.faithMobile` di bundle id iOS
- [ ] Samakan bundle id/applicationId dengan app kirain di semua platform; hanya nama app yang beda
- [ ] Kirim email ke YLSA (ylsa@sabda.org) soal pemakaian AYT di app gratis, simpan jawabannya
- [ ] Bila ada rencana donasi atau monetisasi, konfirmasi ke YLSA lebih dulu (lisensi AYT non-komersial)
- [ ] Pastikan service account key tidak pernah masuk git (`*-firebase-adminsdk-*.json` di `.gitignore`)
