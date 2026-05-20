---
stage: implement
bolt: 006-design-system-base
created: 2026-05-20T16:22:53Z
---

## Implementation Walkthrough: 006-design-system-base

### Summary
Refactored theme into explicit design tokens (colors/spacing/radius/typography), wired tokens into `AppTheme`, added core shared widgets: `FaithButton`, `FaithCard`, `FaithListItem`.

### Structure Overview
- Theme tokens: `lib/app/theme/`
  - `app_colors.dart`
  - `app_spacing.dart`
  - `app_radius.dart`
  - `app_text_styles.dart`
  - `app_theme.dart`
- Core widgets: `lib/app/widgets/`
  - `faith_button.dart`
  - `faith_card.dart`
  - `faith_list_item.dart`
  - `widgets.dart` (barrel)

### Completed Work
- [x] Added token files for colors/spacing/radius/typography.
- [x] Updated `AppTheme` to consume token files (ColorScheme/TextTheme/Button/Input).
- [x] Implemented core widgets (Button/Card/ListItem) with minimal stable APIs.

### Key Decisions
- Token-first: screens/components depend on tokens, not ad-hoc constants.
- Keep default font for now (`fontFamily` unset) → avoids asset + pubspec churn.

### Deviations from Plan
- Widgets path used `lib/app/widgets/` (not `lib/shared/widgets/`) to match existing app structure.

### Dependencies Added
None.

### Developer Notes
Next: add higher-level patterns (section headers, empty states) once first screens exist.
