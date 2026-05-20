---
stage: plan
bolt: 001-flutter-project-init
created: 2026-05-20T07:30:00Z
---

## Implementation Plan: 001-flutter-project-init

### Objective
Create runnable Flutter baseline in `fAIth_mobile/` with GetX routing skeleton + lint.

### Deliverables
- Flutter project in `fAIth_mobile/` builds/runs.
- GetX installed + `GetMaterialApp` entry.
- Route map file (`lib/app/routes/app_routes.dart`).
- Minimal pages: Splash, Login, Shell, Home, Chat, Study, Devotional, Profile.
- `analysis_options.yaml` present.

### Dependencies
- Flutter SDK installed locally.
- No Firebase configuration yet (handled in Bolt 002). Until then, app must not require `firebase_options.dart`.

### Technical Approach
1 - Keep app boot minimal: no Firebase init in `main.dart` yet.
2 - Use feature-first-ish scaffold: `lib/app/pages/*`, `lib/app/routes/*`, `lib/app/theme/*`.
3 - Wire routes via `GetPage` list; set initialRoute to Splash.
4 - Ensure placeholder pages are simple `Scaffold` with titles.

### Acceptance Criteria
- [ ] `flutter analyze` passes.
- [ ] `flutter run` boots without crash.
- [ ] `GetMaterialApp` wired with `getPages`.
- [ ] `analysis_options.yaml` exists.
- [ ] After UI/function change → hot reload → no crash.
