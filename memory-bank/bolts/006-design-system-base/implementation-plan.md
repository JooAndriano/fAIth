---
stage: plan
bolt: 006-design-system-base
created: 2026-05-20T16:22:53Z
---

## Implementation Plan: 006-design-system-base

### Objective
Establish light-mode design system baseline for `fAIth_mobile`: theme tokens, typography scale, and reusable core widgets.

### Deliverables
- `memory-bank/bolts/006-design-system-base/implementation-plan.md` (this file)
- Theme token files for colors, spacing, radius, shadows/elevation
- Global `ThemeData` wired into app root
- Typography definitions mapped to Material text theme
- Core widgets: Button, Card, ListItem (minimal reusable API)
- `implementation-walkthrough.md`
- `test-walkthrough.md`

### Dependencies
- `001-flutter-project-init`
- Existing app root in `fAIth_mobile` where `ThemeData` can be applied

### Technical Approach
- Add `lib/app/theme/` (or existing equivalent) for:
  - `app_colors.dart`
  - `app_spacing.dart`
  - `app_radius.dart`
  - `app_text_styles.dart`
  - `app_theme.dart`
- Define light palette:
  - Primary
  - Accent/secondary
  - Background/surface
  - Text colors
  - Border/divider
  - Success/warning/error where useful
- Define typography scale:
  - display/title/body/label styles
  - readable defaults, Material-compatible
- Wire `AppTheme.lightTheme` into `GetMaterialApp` / `MaterialApp`
- Add shared widgets under `lib/app/widgets/`:
  - `FaithButton`
  - `FaithCard`
  - `FaithListItem`
- Keep APIs small, stable, nullable-safe.
- Prefer const constructors where possible.

### Acceptance Criteria
- [ ] Primary/Accent/Background colors applied in app theme
- [ ] Typography scale exists and maps to `TextTheme`
- [ ] Global theme wired into app root
- [ ] Reusable Button widget exists
- [ ] Reusable Card widget exists
- [ ] Reusable ListItem widget exists
- [ ] Widgets compile with const-friendly APIs
- [ ] Light mode baseline complete
- [ ] No analyzer errors introduced

### Test Plan
- Run Flutter analyze
- Run app/smoke build if environment available
- Verify a themed screen renders using global theme
- Verify Button/Card/ListItem can be instantiated without crash
