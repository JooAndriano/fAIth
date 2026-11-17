---
intent: 002-static-ui
created: 2026-11-16T14:45:00Z
updated: 2026-11-17T04:00:00Z
---

# Inception Log — Intent 002: Static UI

## 2026-11-16T14:45:00Z — Intent created
- Source: user brief "FASE 2 = STATIC UI" (port fAIth_web screens with Indonesian dummy data; Auth real).
- Inputs read: project.yaml, standards/*, story-index.md, fAIth_web/src (all screens + theme.css), current lib/.
- Prototype findings that shaped scope:
  - Prototype tabs are Home / Ask fAIth / Bible / Prayer / Settings (Flutter shell currently differs) → D1.
  - Prototype copy is English, no i18n; language picker is cosmetic → D2.
  - No book/chapter picker, verse marking, typing indicator, loading/error states or message quota in prototype;
    these are new UI defined by this intent.
  - Prototype bugs (back always to Home, All Prayers sheet never opens, AdditionalSettings missing onBack,
    many inert buttons) → D5.
  - Chat screen uses hardcoded hex colors (ignores dark mode); navy text low-contrast in dark → handled by theme extension.
  - Existing AppTextStyles hardcode light foreground color → fixed in unit 001.
- Status: awaiting user approval of requirements, decisions D1–D6, units and bolt plan.

## 2026-11-17T04:00:00Z — Aligned with Phase 3 decisions
- Phase 3 brief received before Phase 2 was built; user chose to finish Phase 2 first.
- Added D7–D10 (devotional format, Bible by translation + reference-based favorites, paginated chat history,
  About skeleton) so Phase 3 only swaps Mock → Firestore implementations.
- Branch policy: all work directly on `develop` (feat/phase-2-static-ui fast-forwarded into develop).
- Status: awaiting user approval of D1–D10 before bolt 007.
