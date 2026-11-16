# Story 001-theme-extension — Brand theme extension and theme-aware text

**Intent:** 002-static-ui  
**Unit:** 001-ui-foundation  
**Priority:** Must  
**Status:** Draft

## Acceptance Criteria
- `FaithColors` ThemeExtension (gold, sunset, navy header gradient, highlight gradient, goldBorder) with light and dark values from fAIth_web theme.css
- Widgets read text styles from `Theme.of(context).textTheme` (no hardcoded foreground color)
- Dark mode keeps navy surfaces readable (no navy text on dark background)
