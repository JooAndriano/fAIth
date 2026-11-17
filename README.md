# faith

Personal AI Spiritual Companion — aplikasi Flutter (GetX + Firebase) untuk Android & iOS.

| | |
|---|---|
| Nama app (tampil ke user) | `faith` |
| Android applicationId / namespace | `id.jivottama.faith` |
| iOS bundle id | `id.jivottama.faith` |
| Paket Dart | `faith_mobile` |
| Project Firebase | `faith-514ef` |

## Struktur repo

```
lib/                 # kode app (lihat docs/ARCHITECTURE.md)
test/                # unit & widget test
android/ ios/        # platform
firebase.json, .firebaserc, firestore.rules, firestore.indexes.json
content/devotionals/ # renungan (JSON) untuk di-seed
tools/seed/          # skrip seed Firestore (Node, Admin SDK)
docs/                # arsitektur, Firestore, keputusan, rencana
```

## Menjalankan secara lokal

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

Seed Firestore: lihat `tools/seed/README.md` dan `docs/FIRESTORE.md`.
