# Bolt Plan — Intent 002: Android UI Parity (Web → Mobile)

**Intent:** 002-android-ui
**Status:** Draft
**Created:** 2026-05-21T00:00:00Z

## Bolt Strategy
One bolt per unit (BBB == UUU style for clarity), focused on visual parity and minimal logic change.

## Planned Bolts

### Bolt 001 — theme-and-tokens
- **Unit:** 001-theme-and-tokens
- **Goal:** Align Flutter color/typography tokens to web.
- **Outputs:** ThemeData, color constants, text styles.

### Bolt 002 — splash-and-icon
- **Unit:** 002-splash-and-icon
- **Goal:** Splash parity + Android icon update.
- **Outputs:** Splash UI, icon assets/config.

### Bolt 003 — auth-ui
- **Unit:** 003-auth-ui
- **Goal:** Login UI parity; keep auth logic.
- **Outputs:** Styled auth page components.

### Bolt 004 — bottom-nav-shell-ui
- **Unit:** 004-bottom-nav-shell-ui
- **Goal:** Bottom bar parity + label updates.
- **Outputs:** Tabs = Home, Ask fAIth, Bible, Prayer, Settings; active dot/gold state; safe area fix.

### Bolt 005 — home-ui
- **Unit:** 005-home-ui
- **Goal:** Home screen visual parity.
- **Outputs:** Home sections/cards/spacing aligned.

### Bolt 006 — ask-faith-chat-ui
- **Unit:** 006-ask-faith-chat-ui
- **Goal:** Chat/AI page parity with tab label Ask fAIth.
- **Outputs:** Chat layout, bubbles, composer, tab label update.

### Bolt 007 — bible-ui
- **Unit:** 007-bible-ui
- **Goal:** Build Bible page in Bible Study slot.
- **Outputs:** Bible page scaffold with **Lorem Ipsum** placeholder text first.

### Bolt 008 — prayer-ui
- **Unit:** 008-prayer-ui
- **Goal:** Build Prayer page in Daily Devotionals slot.
- **Outputs:** Prayer page scaffold with **Lorem Ipsum** placeholder text first; bottom tab label Prayer.

### Bolt 009 — settings-profile-ui
- **Unit:** 009-settings-profile-ui
- **Goal:** Settings/profile pages parity.
- **Outputs:** Settings list/item patterns + profile settings UI.

## Notes
- Keep GetX navigation/state intact; UI layer refactor only.
- Placeholder copy allowed (Lorem Ipsum) for Bible/Prayer content until content wiring phase.
