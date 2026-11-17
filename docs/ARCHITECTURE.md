# Arsitektur

App Flutter (Android & iOS), state management + DI + routing dengan GetX, backend Firebase
(Auth + Firestore). Paket Dart: `faith_mobile`.

## Struktur `lib/`

```
lib/
  main.dart                 # Firebase.initializeApp + GetMaterialApp
  firebase_options.dart     # generated (flutterfire configure), dikecualikan dari analyze
  core/
    bindings/app_bindings.dart   # DI global: interface -> implementasi
    routes/app_routes.dart       # nama route + tabel GetPage
    routes/auth_middleware.dart  # redirect ke /login bila belum login
    theme/                       # AppColors, AppTheme (light/dark), FaithColors (ThemeExtension),
                                 # AppSpacing, AppRadius, AppTextStyles
  shared/
    data/mock_latency.dart       # delay simulasi untuk repo Mock
    state/view_state.dart        # sealed ViewState<T>: Loading/Empty/Error/Data
    widgets/                     # design system: FaithButton, FaithCard, GradientHeader,
                                 # StateViews/ViewStateBuilder, ComingSoonPage, ... (barrel: widgets.dart)
  features/<fitur>/
    domain/   models/ + repositories/ (interface)
    data/     implementasi repository / service
    presentation/ pages/ controllers/ bindings/ widgets/
```

Fitur yang ada: `auth`, `splash`, `shell` (5 tab), `home`, `bible`, `devotional`, `favorites`,
`churches`, `chat`, `prayer`, `settings`, `profile`, `not_found`. Tab chat, bible, prayer, dan settings
masih placeholder. Sub-layar yang belum dibuat diarahkan ke `ComingSoonPage` (lihat `_pendingScreens`
di `app_routes.dart`).

## Pola repository (interface + implementasi)

- Interface berupa `abstract interface class` di `features/<f>/domain/repositories/`,
  contohnya `DevotionalRepository`, `BibleRepository`, `FavoriteVerseRepository`, `ChurchRepository`,
  dan `VerseOfDayRepository` (yang terakhir ada di `home/domain/`).
- Implementasi di `data/`. **Saat ini semuanya Mock/Local** (`MockDevotionalRepository`,
  `MockBibleRepository`, `LocalVerseOfDayRepository`, …) dengan delay `kMockLatency`.
  Implementasi Firestore belum ada (Fase 3).
- Binding **hanya** di `AppBindings` (`Get.lazyPut<Interface>(Impl.new, fenix: true)`). Untuk
  beralih ke Firestore cukup mengganti binding-nya, controller tidak perlu diubah.
- Controller menerima dependensi lewat konstruktor (lihat `HomeController`, di-wire oleh
  `ShellBinding` dengan `Get.find()`), jadi di test cukup diberi fake (`test/helpers/fakes.dart`).
- Tiap section data diekspos sebagai `Rx<ViewState<T>>` dan dirender dengan `ViewStateBuilder`,
  sehingga satu sumber yang gagal tidak menyembunyikan section lain.
- Model domain bersifat immutable (`@immutable`, `final` fields) dan tidak memakai tipe Firebase.
  Contohnya `AppUser`, bukan `User`.

## Alur auth

1. `main.dart` menjalankan `Firebase.initializeApp`, lalu `AppBindings` mendaftarkan
   `AuthController` (permanent, juga sebagai `UserSession`).
2. `AuthController` mendengarkan `authStateChanges()` dari `AuthService`.
3. `SplashPage` mengarahkan ke `/shell` bila sudah login, atau ke `/login` bila belum.
4. `LoginPage` memanggil `AuthController.signInWithGoogle()`, yang menjalankan `AuthService`:
   Google Sign-In → `signInWithCredential`, lalu `syncUserProfile` membuat dokumen `users/{uid}`
   dengan default bila belum ada, atau meng-update field identitas + `updatedAt` bila sudah ada.
5. Route yang terlindungi (`/shell`, `/profile`, sub-layar) memakai `AuthMiddleware`.
6. Logout: `GoogleSignIn.signOut()` lalu `FirebaseAuth.signOut()`.

## Navigasi

`/splash`, `/login`, `/shell` (tab: Beranda, Tanya fAIth, Alkitab, Doa, Pengaturan; tab dipilih lewat
`ShellController.select`). Layar lain di-push di atas shell dengan `Get.toNamed`, sehingga tombol back
kembali ke layar sebelumnya. Route yang tidak dikenal diarahkan ke `NotFoundPage`.

## Tema

Token warna berasal dari prototipe web (tag `archive/web-prototype`). `AppTheme.lightTheme`/`darkTheme`
sudah ada, tetapi `main.dart` masih mengunci `ThemeMode.light`. Nuansa yang dituju: tenang, hangat,
lapang; teks minimal 14sp; sudut membulat.

## Konvensi coding (yang benar-benar dipakai)

- Lint: `flutter_lints` + aturan tambahan di `analysis_options.yaml` (strict-casts, strict-raw-types,
  single quotes, trailing commas wajib, `prefer_final_locals`, `unawaited_futures`, `avoid_print`,
  `directives_ordering`, `use_super_parameters`). `flutter analyze` harus bersih.
- Format: `dart format` dengan page width **100**, indentasi 2 spasi.
- Feature-first. Nama file `snake_case`, kelas `PascalCase`.
- Import antar-folder memakai `package:faith_mobile/...`, import relatif hanya untuk file sefolder.
- Logika tidak ditaruh di widget; letakkan di controller atau domain. DI lewat GetX.
- DartDoc `///` untuk API publik, dan komentar menjelaskan *mengapa*.
- Teks UI dalam Bahasa Indonesia (belum ada i18n).
- Test di `test/` dengan pola nama `<target>_test.dart` dan struktur cermin `lib/`
  (`test/core`, `test/features`, `test/shared`, helper di `test/helpers`).
