# faith

Personal AI Spiritual Companion — aplikasi Flutter (GetX + Firebase) untuk Android & iOS.

| | |
|---|---|
| Nama app (tampil ke user) | `faith` |
| Android applicationId / namespace | `id.jivottama.faith` |
| iOS bundle id | `id.jivottama.faith` |
| Paket Dart | `faith_mobile` |

## Struktur `lib/`

```
lib/
  main.dart              # bootstrap Firebase + GetMaterialApp
  firebase_options.dart  # generated oleh `flutterfire configure`
  core/                  # bindings, routes, theme
  shared/widgets/        # widget design system (FaithButton, FaithCard, ...)
  features/<nama>/       # auth, splash, shell, home, chat, devotional, study, profile, not_found
    data/                # service / repository
    presentation/        # pages & controllers (GetX)
```

## Menjalankan secara lokal

Langkah lengkap (termasuk setup Firebase) ada di bagian berikutnya setelah migrasi Firebase selesai.

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```
