# Inception Log — Intent: Project Setup (001)

**Intent Title:** Project Setup
**Phase:** 1
**Created:** 2026-05-20T07:00:30Z
**Owner:** Inception Agent

## Intent Description

Initialize the fAIth mobile app with all base technical setup, including:
- Flutter project creation
- Firebase project linkage
- Auth config (Google Sign-In)
- Firestore structure
- Routing (GetX)
- Theme system and navigation shell

This phase covers all technical bootstrapping to unlock further development phases.

---

## Units

- 001-flutter-project-init
- 002-firebase-setup
- 003-auth-flow
- 004-firestore-structure
- 005-navigation-setup
- 006-design-system-base

(Unit details and associated stories elaborated below)

---

## Unit: 001-flutter-project-init

Goal: Create initial Flutter project for mobile in `fAIth_mobile/`, with base packages, GetX, and base folder structure.

Stories:
- S001-setup-flutter-project: `Create Flutter app scaffold (fAIth_mobile)`
- S002-add-getx: `Add GetX dependency, setup routing skeleton`
- S003-setup-lint: `Add analysis_options.yaml and lint rules`

Acceptance Criteria:
- Flutter project created under `fAIth_mobile/`
- `lib/` follows feature-first structure
- `get` package installed and basic routing works

---

## Unit: 002-firebase-setup

Goal: Initialize Firebase project linkage and required services.

Stories:
- S001-firebase-project: `Link Firebase project, configure Android/iOS apps`
- S002-firestore-setup: `Create base Firestore collections and rules`
- S003-functions-setup: `Initialize Firebase Functions (TypeScript) and deploy skeleton`

Acceptance Criteria:
- Firebase project linked
- Firestore collections `users`, `chat_history`, `prayers` created (or seeded)
- Functions deployable from local dev

---

## Unit: 003-auth-flow

Goal: Implement Firebase Google Sign-In flow with persistent user profile storage.

Stories:
- S001-google-signin: `Implement Google Sign-In, handle tokens`
- S002-profile-sync: `Persist basic user profile in Firestore under users/{uid}`
- S003-session: `Manage session state and signout`

Acceptance Criteria:
- Users can sign in with Google
- Profile saved in Firestore with schema matching project.yaml

---

## Unit: 004-firestore-structure

Goal: Define and implement Firestore schema for core collections.

Stories:
- S001-define-schema: `Document field definitions for users, devotions, prayers, chat_history`
- S002-security-rules: `Write Firestore security rules for user data`
- S003-indexes: `Create required Firestore indexes`

Acceptance Criteria:
- Clear schema documents created
- Security rules implemented and tested

---

## Unit: 005-navigation-setup

Goal: Setup GetX-based routing and navigation shell with bottom navigation.

Stories:
- S001-shell: `Create navigation shell with BottomNavigationBar`
- S002-routes: `Define typed routes and route guards for auth`
- S003-shell-states: `Manage shell state and selected tab persistence`

Acceptance Criteria:
- Navigation shell displays Home/Chat/Study/Devotional/Profile tabs
- Route guards prevent unauthenticated access

---

## Unit: 006-design-system-base

Goal: Create base theme, typography, and core widgets.

Stories:
- S001-theme: `Define ThemeData with primary, accent, background colors`
- S002-typography: `Define text styles and scale`
- S003-core-widgets: `Create Button, Card, ListItem components`

Acceptance Criteria:
- App theme applied globally
- Reusable components present in `lib/shared/widgets`

---

**Next:** Run `/specsmd-inception-agent elaborate 001 {unit}` to generate stories in files.
