---
id: 007-ui-foundation
unit: 001-ui-foundation
intent: 002-static-ui
type: simple-construction-bolt
status: completed
stories: [001-theme-extension, 002-shared-widgets, 003-view-state, 004-shell-routes]
created: 2026-11-16T14:45:00Z
started: 2026-11-17T04:10:00Z
completed: 2026-11-17T05:00:00Z
current_stage: done
stages_completed: [implement, test]
requires_bolts: []
---

# Bolt: 007-ui-foundation

## Objective
Shared design foundation and navigation shell used by every screen.

## Definition of Done
- Stories of unit `001-ui-foundation` meet their acceptance criteria.
- `flutter analyze` clean, `flutter test` green.
- Light and dark checked; no overflow at 320dp / text scale 1.3.
- One commit: `feat(<scope>): complete bolt 007-ui-foundation`.

## Result
- `FaithColors` ThemeExtension (`context.faith`): gold, sunset, header/highlight/action gradients,
  goldBorder, onHeader, onAction; light + dark. `AppTheme` built from one recipe for both brightnesses.
- `AppTextStyles` no longer hardcodes a color; `textTheme()` colors per brightness (min 14sp).
- Shared widgets: GradientHeader, SectionHeader, HighlightCard, GradientButton, ChipSelector,
  showAppBottomSheet + SheetAction, EmptyState/LoadingState/ErrorState, ViewStateBuilder,
  showComingSoon + ComingSoonPage.
- `ViewState<T>` sealed type (`lib/shared/state/view_state.dart`).
- Shell: 5 tabs (Beranda, Tanya fAIth, Alkitab, Doa, Pengaturan) in an IndexedStack; back from
  another tab returns to Beranda. Sub-routes registered and auth-guarded; screens not built yet use
  ComingSoonPage. Interim Settings tab lists all sub-screens (replaced in bolt 014).
- `features/study` renamed to `features/bible`; devotional tab placeholder removed (now a sub-route).

## Deviations
- Text on the gold→sunset gradient is navy, not the prototype's ivory (ivory fails contrast).

## Verification
- `flutter analyze`: no issues. `flutter test`: 51 passed (widgets in light/dark and 320dp x1.3).
- Not yet checked on a physical device.
