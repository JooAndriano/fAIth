# fAIth (faith)

Personal AI Spiritual Companion: app Flutter untuk Android & iOS yang berisi renungan harian,
pembaca Alkitab (AYT/KJV/WEB), jurnal doa, ayat favorit, dan chat AI rohani. App gratis total.
Stack: Flutter + GetX (state, DI, routing) + Firebase Auth (Google Sign-In) + Cloud Firestore.
Paket Dart `faith_mobile`, applicationId `id.jivottama.faith`. UI berbahasa Indonesia.

## Perintah

```sh
flutter pub get
flutter analyze                 # harus bersih
flutter test
flutter run
flutter build apk --debug
dart format --line-length 100 lib test

firebase deploy --only firestore:rules   --project faith-514ef
firebase deploy --only firestore:indexes --project faith-514ef
firebase emulators:start --only firestore     # butuh Java 21

# Seed renungan (dari tools/seed; npm install && npm test sekali)
node seed-devotionals.mjs --project faith-514ef --dry-run
node seed-devotionals.mjs --emulator
node seed-devotionals.mjs --project faith-514ef   # butuh GOOGLE_APPLICATION_CREDENTIALS (key di luar repo)
#   opsi: --database <id>  --collection <name> (default devotionals)  --dir <path>
```

## Struktur

```
lib/core/            bindings (DI global), routes (+ AuthMiddleware), theme
lib/shared/          widgets design system, ViewState, mock_latency
lib/features/<f>/    domain/ (models, repository interface) · data/ (impl) · presentation/
test/                cermin lib/, fake di test/helpers/fakes.dart
content/devotionals/ renungan JSON (draft/published)
tools/seed/          seed Firestore via Admin SDK (Node 20+)
tools/rules-test/    rules test Firestore di emulator (project demo-faith)
docs/                ARCHITECTURE, FIRESTORE, DECISIONS, PLAN
```

## Konvensi

- Controller hanya bicara ke **interface** repository. Implementasi (Mock sekarang, Firestore nanti)
  di-bind **hanya** di `lib/core/bindings/app_bindings.dart`. Repo Mock dipertahankan untuk test.
- Dependensi controller lewat konstruktor, di-wire di `Bindings` dengan `Get.find()`.
- State data: `Rx<ViewState<T>>` + `ViewStateBuilder`. Model domain immutable, tanpa tipe Firebase.
- Feature-first, file `snake_case`, import `package:faith_mobile/...`, single quotes, trailing commas,
  baris maks. 100. Logika tidak ditaruh di widget.
- Firestore: paginasi 20, tanpa listener pada koleksi besar.
- Teks Alkitab dibundel sebagai asset (bukan Firestore). Jangan pernah memakai TB/BIS/TL.
- Commit kecil dengan conventional commits. Jangan push tanpa izin.

## Keamanan (wajib)

- **Jangan pernah membaca, menampilkan, atau meng-commit** service account key
  (`*-firebase-adminsdk-*.json`), `.env*`, `local.properties`, `key.properties`, `*.jks`/`*.keystore`.
  Key admin disimpan di luar repo dan dipakai lewat `GOOGLE_APPLICATION_CREDENTIALS`.
- Project Firebase aktif: **faith-514ef**. Jangan memakai project lain.
- Jangan mengubah `firestore.rules` tanpa menjalankan rules test di emulator
  (`cd tools/rules-test && npm test`, butuh Java 21). Koleksi yang belum punya test: tulis dulu
  test-nya sebelum mengubah rules-nya.
- Jangan memanggil API AI berbayar tanpa izin. Gateway AI direncanakan lewat Cloudflare Worker,
  bukan klien langsung.

## Rujukan

- `docs/PLAN.md`: fase, status, dan pekerjaan berikutnya
- `docs/ARCHITECTURE.md`: struktur lib/, pola repository, alur auth, konvensi
- `docs/FIRESTORE.md`: koleksi, rules, indexes, seed, masalah yang diketahui
- `docs/DECISIONS.md`: keputusan produk/teknis
