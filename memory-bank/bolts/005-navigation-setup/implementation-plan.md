---
stage: plan
bolt: 005-navigation-setup
created: 2026-05-20T16:22:53Z
---

## Implementation Plan: 005-navigation-setup

### Objective
Bottom navigation shell + centralized GetX routes + basic auth guard wiring (scaffold) aligned w/ `fAIth_web` IA.

### Deliverables
- `memory-bank/bolts/005-navigation-setup/implementation-plan.md` (this file)
- BottomNav shell (5 tabs): Home, Chat, Study, Devotional, Profile (placeholder pages ok)
- Central route map (GetX `GetPage` list) incl. unknown route handler
- Guard mechanism scaffold for auth-only routes (hook to existing Auth state; if missing, stub interface)

### Dependencies
- GetX routing already added/available (from `001-flutter-project-init`)
- Auth state source (from `003-auth-flow`) for guard decision (if not ready → temporary fake `isAuthed` provider)

### Technical Approach
- Define route names (constants) + `AppPages.pages: List<GetPage>`
- Build `NavShellPage` w/ `BottomNavigationBar`
- Shell controller: selectedIndex (reactive), tab switching updates route/view
- Unknown route → fallback page (safe)
- Guard: `GetMiddleware` (or equivalent) checks auth → redirect to sign-in/onboarding route

### Acceptance Criteria
- [ ] Bottom tabs exist: Home, Chat, Study, Devotional, Profile
- [ ] Each tab routes to placeholder screen w/o crash
- [ ] Central route map exists (GetX `GetPage` list)
- [ ] Guard mechanism exists for auth-only routes
- [ ] Default/unknown route handled (no crash)
- [ ] Selected tab state in GetX controller
- [ ] Back behavior reasonable (no infinite stack)
