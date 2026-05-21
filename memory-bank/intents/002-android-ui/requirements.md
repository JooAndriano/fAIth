# Requirements — Intent 002: Android UI Parity (Web → Mobile)

**Intent:** 002-android-ui
**Status:** Draft
**Created:** 2026-05-21T00:00:00Z

## Scope
Align **Flutter mobile UI** (`fAIth_mobile/`) to match **existing web reference UI** (`fAIth_web/`) at the level of:
- Layout structure
- Colors + typography
- Core components look/feel

**In scope screens (Phase 1 parity):**
- Splashscreen
- Auth (Login)
- Home
- Chat/AI
- Profile / Settings
- App icon (Android launcher icon; iOS later if needed)

**Out of scope (for this intent):**
- Backend behavior changes (Firebase/Auth logic changes beyond UI wiring)
- Pixel-perfect parity (allowed minor platform adaptations)
- New features not present in web

## Reference of Truth (Web)
Source: `D:/PROJECT/fAIth/fAIth_web/src/app/components/*`
Key screens/components observed:
- `SplashScreen.tsx`
- `LoginScreen.tsx`
- `HomeScreen.tsx`
- `AIChatScreen.tsx`
- `SettingsScreen.tsx` (+ `ProfileSettingsScreen.tsx`, `AdditionalSettingsScreen.tsx`)
- `BottomNavigation.tsx`

## Functional Requirements

### FR-1: Theme parity (colors + typography)
**Description:** Implement Flutter `ThemeData` + text styles mirroring web’s tone (calm, warm, spiritual) and token palette.
- **Acceptance Criteria:**
  - Global theme applied across target screens.
  - Typography scale consistent; all text ≥ 14sp (per UX standard).
  - Colors match web intent: navy/dark backgrounds for splash; ivory/beige/gold accents for auth + main UI.

### FR-2: Splashscreen parity
**Description:** Flutter splash page matches web splash layout: dark gradient background, subtle blurred orbs, centered app icon + branding.
- **Acceptance Criteria:**
  - Gradient background equivalent to web (navy → near-black).
  - App icon shown (rounded 3xl feel) + glow effect.
  - Simple entrance animation (scale/opacity) acceptable.

### FR-3: Auth/Login screen parity
**Description:** Flutter login screen mirrors web: logo header, welcome copy, illustration placeholder card, “Continue with Google” button style.
- **Acceptance Criteria:**
  - Layout sections match (top logo, center content, bottom footer).
  - Button styling: rounded corners, border, shadow, icon placeholder.
  - Hooks into existing auth flow (no new auth logic required).

### FR-4: Bottom navigation parity (shell)
**Description:** Bottom navigation visual parity with web: 5 items + active state gold + dot indicator.
- **Acceptance Criteria:**
  - Tabs: Home, Ask fAIth (Chat), Bible, Prayer, Settings (labels can be localized later).
  - Active tab: gold color + dot indicator.
  - Respects safe area; no overlap with content.
  - Keep GetX navigation/state as-is (adapt UI wrapper only).

### FR-5: Home screen parity
**Description:** Flutter Home screen layout aligns with web structure (sections/cards/spacing), using shared components.
- **Acceptance Criteria:**
  - Main visual hierarchy similar (header, cards/sections).
  - Uses shared Card/Button styles.

### FR-6: Chat/AI screen parity
**Description:** Flutter Chat screen matches web UI patterns (chat header, message bubbles, input composer).
- **Acceptance Criteria:**
  - Message list styles + bubble radii aligned.
  - Input bar pinned bottom above nav.

### FR-7: Profile/Settings parity
**Description:** Flutter Settings + Profile Settings pages mirror web’s list-item patterns, spacing, and navigation.
- **Acceptance Criteria:**
  - Settings list items consistent component.
  - Profile settings edit sections present (even if values are placeholders until wired).

### FR-8: App icon parity (Android)
**Description:** Update Android launcher icon to match web’s `faith-icon.png` style.
- **Acceptance Criteria:**
  - Android adaptive icon updated (foreground/background) or single icon if minimal.
  - Icon renders well on light/dark launcher backgrounds.

## Non-Functional Requirements

### NFR-1: Accessibility
- Text ≥ 14sp; sufficient contrast; images have semantic labels/alt where applicable.

### NFR-2: Performance
- No jank on tab switch; avoid heavy blur on low-end devices (allow fallbacks).

### NFR-3: Maintainability
- Shared UI components centralized (Button/Card/ListItem/NavItem).
- No business logic inside Widgets; UI reads state via existing GetX controllers.

## Constraints / Standards
- Follow `memory-bank/standards/ux-standard.md` (calm/warm, premium spacing, rounded corners ≥ 8px).
- Keep GetX navigation/state management unchanged (UI layer refactor only).
- Target: mobile app (Android first; iOS not blocked).
