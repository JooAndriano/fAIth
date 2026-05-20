# Requirements — Intent 001: Project Setup

**Intent:** 001-project-setup
**Status:** Draft
**Created:** 2026-05-20T07:05:00Z

## Scope
Bootstrap fAIth **mobile** app in `fAIth_mobile/` (Flutter + GetX) + Firebase (Auth/Firestore/Functions/Storage/FCM) with base design system + navigation shell.

**Reference UI/Routing:** mirror patterns from `fAIth_web/` (structure, naming, route map, visual style), adapted to Flutter.

## Functional Requirements

### FR-1: Flutter project baseline (fAIth_mobile)
- **Description**: Ensure `fAIth_mobile/` is a runnable Flutter app with agreed folder structure and core dependencies.
- **Acceptance Criteria**:
  - `flutter run` succeeds on Android emulator/device.
  - `pubspec.yaml` includes GetX (`get`) + other base deps agreed during implementation.
  - `lib/` uses feature-first structure (per standards).
  - Linting enabled via `analysis_options.yaml`.
- **Priority**: Must

### FR-2: GetX routing skeleton + navigation shell
- **Description**: Implement initial GetX route configuration + bottom navigation shell aligned with `fAIth_web` route/IA.
- **Acceptance Criteria**:
  - App has `GetMaterialApp` with centralized route definitions.
  - Bottom tabs exist: Home, Chat, Study, Devotional, Profile.
  - Default route resolves without crash.
  - Route guard mechanism exists for authenticated-only routes (can be stubbed until Auth finished, but hook points must exist).
- **Priority**: Must

### FR-3: Global theme + base design system
- **Description**: Implement theme tokens and base widgets to match project design direction.
- **Acceptance Criteria**:
  - Theme applied globally (light mode baseline).
  - Color tokens available: primary `#D4A574`, accent `#C97B63`, dark `#111827`, background `#F8F6F2`.
  - Typography scale defined + reusable text styles.
  - Shared widgets folder exists (e.g., button/card/list-item) usable across screens.
- **Priority**: Must

### FR-4: Firebase project linkage (Android/iOS)
- **Description**: Connect Flutter app to Firebase project and enable required Firebase services.
- **Acceptance Criteria**:
  - Firebase configured for Android (and iOS if available) with correct config files.
  - Firebase initialization runs at app start without errors.
  - Services enabled (at minimum): Auth, Firestore, Functions.
- **Priority**: Must

### FR-5: Google Sign-In authentication flow
- **Description**: Implement Google Sign-In using Firebase Auth; session persists across app restarts.
- **Acceptance Criteria**:
  - User can sign in with Google.
  - Signed-in state persists after app restart.
  - User can sign out.
  - UI has at least a basic login screen + sign-in button (final UI polish later).
- **Priority**: Must

### FR-6: Firestore base schema + user profile sync
- **Description**: Create baseline Firestore collections and save user profile on first login.
- **Acceptance Criteria**:
  - Collection `users/{uid}` created/updated on login.
  - User doc contains at least: `uid`, `name`, `photoUrl`, `favoriteVerse`, `language`, `darkMode`, `dailyMessages`, `usedMessages`.
  - Collections scaffolded (created/seeded/docs): `chat_history`, `prayers` (others may be added later).
- **Priority**: Must

### FR-7: Firebase Functions scaffold (Gemini gateway placeholder)
- **Description**: Setup Firebase Functions (TypeScript) with deployable skeleton; include placeholder HTTPS callable/HTTP endpoint for future Gemini proxy.
- **Acceptance Criteria**:
  - `firebase init functions` completed (TypeScript).
  - Local build works; `firebase deploy --only functions` succeeds.
  - Placeholder endpoint returns a static response (no Gemini call yet).
- **Priority**: Should

### FR-8: Developer ergonomics
- **Description**: Provide docs/commands to run mobile + functions locally; reduce setup friction.
- **Acceptance Criteria**:
  - README notes for running Flutter + Firebase setup steps.
  - Standard workflow: after UI/function changes, hot reload to confirm no crash (per coding standard).
- **Priority**: Should

## Non-Functional Requirements

### NFR-1: Stability (boot)
- **Metric**: Cold start to first frame without crash on supported test device/emulator.

### NFR-2: Performance (UI responsiveness)
- **Metric**: Navigation between bottom tabs completes within 300ms on mid-range device (perceived; no heavy work in UI thread).

### NFR-3: Security (AI + secrets)
- **Metric**: No Gemini API keys shipped in Flutter app; AI calls must be server-side (Functions) only.

### NFR-4: Security (data access)
- **Metric**: Firestore rules prevent reading/writing another user’s `users/{uid}`, `prayers`, `chat_history` data.

### NFR-5: Maintainability
- **Metric**: Feature-first structure; no business logic inside Widgets; basic unit test harness present for non-UI logic.

## Intent-Specific Constraints
- **Mobile focus**: implement in `fAIth_mobile/` (web version exists in `fAIth_web/` as reference only).
- **Routing/UI reference**: follow information architecture + naming patterns from `fAIth_web/`, adapted to Flutter.

