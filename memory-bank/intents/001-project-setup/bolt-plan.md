# Bolt Plan — Intent 001: Project Setup

**Intent:** 001-project-setup
**Status:** Draft
**Created:** 2026-05-20T07:10:00Z

## Bolt Strategy
One bolt per unit (BBB == UUU) to keep execution atomic + traceable.

## Planned Bolts

### Bolt 001 — flutter-project-init
- **Unit:** 001-flutter-project-init
- **Goal:** Create runnable Flutter app in `fAIth_mobile/` with feature-first structure + lint.
- **Outputs:** Flutter scaffold, deps baseline, `analysis_options.yaml`, base app entry.

### Bolt 002 — firebase-setup
- **Unit:** 002-firebase-setup
- **Goal:** Firebase project linkage; enable Auth/Firestore/Functions; init Functions TS skeleton.
- **Outputs:** `google-services.json` / `GoogleService-Info.plist` (if iOS), `firebase.json`, `functions/` scaffold.

### Bolt 003 — auth-flow
- **Unit:** 003-auth-flow
- **Goal:** Google Sign-In UI + session persistence + sign-out.
- **Outputs:** Login screen, auth controller/service, route guards hook.

### Bolt 004 — firestore-structure
- **Unit:** 004-firestore-structure
- **Goal:** Base schema docs + security rules for `users/{uid}`, `prayers`, `chat_history` + scaffolding other collections.
- **Outputs:** `firestore.rules`, seed/docs, minimal test plan.

### Bolt 005 — navigation-setup
- **Unit:** 005-navigation-setup
- **Goal:** GetX routes + bottom nav shell (Home/Chat/Study/Devotional/Profile) aligned to `fAIth_web` IA.
- **Outputs:** Route map, shell scaffold, guard wiring.

### Bolt 006 — design-system-base
- **Unit:** 006-design-system-base
- **Goal:** Theme tokens + typography + core widgets (button/card/list-item).
- **Outputs:** `ThemeData`, color/typography tokens, shared widgets.

## Commit Policy
Atomic commits per story/task (see `memory-bank/standards/coding-standard.md`).
