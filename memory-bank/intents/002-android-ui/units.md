# Units — Intent 002: Android UI Parity (Web → Mobile)

**Intent:** 002-android-ui
**Status:** Draft
**Created:** 2026-05-21T00:00:00Z

## Unit Decomposition

### 001-theme-and-tokens
- **Goal:** Align Flutter ThemeData, colors, typography with web reference.
- **Depends on:** existing design-system base (if present) but may refactor.

### 002-splash-and-icon
- **Goal:** Splashscreen UI parity + Android app icon update.
- **Depends on:** theme/tokens.

### 003-auth-ui
- **Goal:** Login/Auth screens UI parity (layout/components), reuse existing auth logic.
- **Depends on:** theme/tokens.

### 004-bottom-nav-shell-ui
- **Goal:** Bottom navigation UI parity (5 tabs, active state, safe area). Keep GetX navigation logic.
- **Depends on:** theme/tokens.

### 005-home-ui
- **Goal:** Home screen parity (cards/sections/spacing).
- **Depends on:** theme/tokens + shared components.

### 006-chat-ui
- **Goal:** Chat/AI screen parity (bubbles, composer).
- **Depends on:** theme/tokens + nav shell.

### 007-settings-profile-ui
- **Goal:** Settings + profile/settings screens parity (list items, navigation).
- **Depends on:** theme/tokens + shared components.

## Notes
- Units structured to allow parallel-ish bolts but recommended sequence: 001 → 002 → 003 → 004 → 005/006/007.
