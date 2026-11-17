# Keputusan

- Firebase project: faith-514ef (akun profesional). Android applicationId sama dengan app kirain;
  hanya nama app yang berbeda.
- App gratis total, tanpa iklan/langganan/donasi. Teks Alkitab: AYT (lisensi non-komersial YLSA;
  wajib atribusi, jangan ubah teks, konfirmasi ke YLSA sebelum ada monetisasi/donasi), KJV dan WEB
  (domain publik). TB/BIS/TL tidak dipakai (hak cipta LAI). Teks Alkitab dibundel sebagai asset
  di app, bukan di Firestore.
- Renungan dibuat dengan bantuan AI lalu direview manual, di-seed ke Firestore dengan status published.
- Gateway AI (Fase 4): Cloudflare Worker (menyimpan API key, verifikasi token Firebase, rate limit),
  bukan Firebase Functions, agar tetap di paket gratis. Kuota 25 pesan/user/hari.
- Cloudflare R2 (dengan domain sendiri) dipakai untuk media bila perlu.

## Keputusan teknis app (Fase 2, tercermin di kode)

- Tab utama: Beranda, Tanya fAIth, Alkitab, Doa, Pengaturan. Renungan dibuka dari Beranda.
- Teks UI tetap Bahasa Indonesia. Pilihan bahasa hanya disimpan; i18n nyata ada di Fase 7.
- Ikon memakai Material Icons (tanpa dependensi ikon tambahan).
- Model `Devotional` memakai format konten Fase 3: `id, dayNumber, title, verseRef, verseText, body,
  reflectionQuestions[], prayer, tags[], status`. `verseText` dikutip dari asset Alkitab, bukan
  ditulis AI.
- Alkitab dibaca lewat `BibleRepository` berdasarkan kode terjemahan (AYT/KJV/WEB). Ayat favorit
  menyimpan referensi `BOOK:chapter:verse[-end]` + kode terjemahan, bukan teks.
- Riwayat chat dipaginasi sejak awal (20 per halaman, cursor).
- Layar Tentang di Pengaturan memuat atribusi/lisensi AYT–YLSA.
