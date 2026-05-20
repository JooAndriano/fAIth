---
stage: implement
bolt: 005-navigation-setup
created: 2026-05-20T16:22:53Z
---

## Implementation Walkthrough: 005-navigation-setup

### Summary
Implemented GetX route map with auth guard middleware, added unknown-route fallback, and refactored bottom-nav shell to be route-driven so tab switching updates URL/route state.

### Structure Overview
Routing centralized in `AppRoutes` with a single shell wrapper (`ShellPage`) used for all tab routes. Tab selection derives from current route; tab taps navigate via `Get.offNamed`.

### Completed Work

- [x] `lib/app/routes/app_routes.dart` - Centralized routes; tab routes now render `ShellPage` + unknown route page.
- [x] `lib/app/pages/shell/shell_page.dart` - Route-driven BottomNavigationBar + route → index mapping.
- [x] `lib/app/pages/not_found/not_found_page.dart` - Safe fallback screen for unknown routes.
- [x] `lib/main.dart` - Registered `unknownRoute` handler.

### Key Decisions
- **Route-driven shell**: Ensures “switching tabs updates route/view correctly” while keeping a single BottomNav scaffold.

### Deviations from Plan
None.

### Dependencies Added
None.

### Developer Notes
If deeper nested navigation per-tab is needed later, migrate shell to nested navigators (GetX RouterOutlet) per tab.
