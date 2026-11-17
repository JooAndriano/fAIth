---
id: 008-home
unit: 002-home
intent: 002-static-ui
type: simple-construction-bolt
status: completed
stories: [001-home-data, 002-home-screen]
created: 2026-11-16T14:45:00Z
started: 2026-11-17T05:10:00Z
completed: 2026-11-17T06:00:00Z
current_stage: done
stages_completed: [implement, test]
requires_bolts: [007-ui-foundation]
---

# Bolt: 008-home

## Objective
Beranda: the daily landing screen.

## Definition of Done
- Stories of unit `002-home` meet their acceptance criteria.
- `flutter analyze` clean, `flutter test` green.
- Light and dark checked; no overflow at 320dp / text scale 1.3.
- One commit: `feat(<scope>): complete bolt 008-home`.

## Result
- Shared domain (used by later bolts):
  - `bible/domain`: `BibleBooks` (66 books, USFM ids, ID/EN names), `VerseRef` (`BOOK:ch:v[-v]` key),
    `Translation` (AYT/KJV/WEB only), `Passage`, `BibleRepository` (getTranslations, getPassage).
  - `devotional/domain`: `Devotional` in Phase 3 format (D7), `DevotionalRepository.getForDate`.
  - `favorites/domain`: `FavoriteVerse` stores ref + translation code (D8), `getDefault`.
  - `churches/domain`: `Church`, `ChurchRepository.getNearby`.
  - `auth/domain`: `AppUser`, `UserSession` (implemented by AuthController).
  - `home/domain`: `VerseOfDayRepository` + `LocalVerseOfDayRepository` (no backend needed).
- Mock repos with simulated latency (`shared/data/mock_latency.dart`); all bound in `AppBindings`.
- `HomeController`: per-section ViewState, greeting by hour, first name fallback "Sahabat".
- Beranda: navy header with greeting, avatar (photo/initial → Profil), encouragement card (default
  favorite, or a prompt to pick one), Ayat Hari Ini, Renungan Hari Ini (→ devotional route with id),
  quick actions (switch to Tanya fAIth / Doa tab), Gereja Terdekat teaser. Pull to refresh.
- `ShellBinding` creates ShellController + HomeController. `InlineStateView` for section states.
  `FaithCard` ripple now drawn inside the card.

## Notes
- Mock Indonesian verse texts are short sample paraphrases (not AYT, not TB); replaced by the AYT asset
  in Phase 3. KJV samples are public domain. A TB quote that slipped into a widget test was removed.

## Verification
- `flutter analyze`: no issues. `flutter test`: 84 passed (Beranda light/dark, 320dp x1.3).
