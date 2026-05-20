---
stage: test
bolt: 006-design-system-base
created: 2026-05-20T16:22:53Z
---

## Test Walkthrough: 006-design-system-base

### Checks
1. `flutter analyze` → expect 0 issues.
2. App boot → verify light theme applied (scaffold bg, app bar, bottom nav).
3. Instantiate widgets in any screen:
   - `FaithButton(label: ..., onPressed: ...)`
   - `FaithCard(child: ...)`
   - `FaithListItem(title: ...)`

### Notes
If analyzer errors: likely missing dirs in git / import paths. Ensure files exist under:
- `lib/app/theme/*`
- `lib/app/widgets/*`
