---
intent: 002-static-ui
phase: inception
status: draft
created: 2026-11-16T14:45:00Z
updated: 2026-11-16T14:45:00Z
---

# Requirements — Intent 002: Static UI

## Intent Overview
Port every screen of the `fAIth_web/` React prototype to Flutter in `fAIth_mobile/`, driven by
**Indonesian dummy data** behind abstract repositories. Only Auth is real (Firebase Google Sign-In).
Firestore, AI (Gemini via Functions), maps and notifications stay out of scope.

## Business Goals
| Goal | Success Metric | Priority |
|------|----------------|----------|
| Complete, navigable app UI for user testing | Every prototype screen reachable on device, no dead taps except explicitly "Segera hadir" items | Must |
| Phase 3 can swap data sources without touching UI | Every feature controller depends only on an abstract repository; Mock impl bound in DI | Must |
| Visual quality in both themes | Light & dark screenshots of each screen reviewed, no hardcoded colors/sizes | Must |
| Accessible on small screens / large text | No overflow at 320dp width with text scale 1.3 (widget tests) | Must |

---

## Functional Requirements

### FR-0: UI foundation
- Navigation shell with 5 tabs matching the prototype: **Beranda, Tanya fAIth, Alkitab, Doa, Pengaturan**
  (replaces current Home/Chat/Study/Devotional/Profile). Devotional, Nearby Churches, Favorite Verses,
  Profile etc. become pushed sub-screens with a real back stack (prototype always returned to Home — not copied).
- Theme extension for brand tokens not covered by `ColorScheme` (gold, sunset, navy header gradient,
  highlight gradient, gold border), resolved per light/dark. Text styles taken from `Theme.of(context)`
  (current `AppTextStyles` hardcode the light foreground color → fixed here).
- Shared widgets: `GradientHeader`, `SectionHeader`, `HighlightCard`, `GradientButton`, `ChipSelector`,
  `EmptyState`, `LoadingState`, `ErrorState` (with retry), `AppBottomSheet`; reuse `FaithButton`/`FaithCard`/`FaithListItem`.
- `ViewState<T>` pattern (loading / empty / error / data) used by every controller.
- **Priority**: Must

### FR-1: Home (Beranda)
- Greeting by time of day + first name from the real Auth user (fallback "Sahabat").
- Daily encouragement card (from the user's default favorite verse), Verse of the Day card,
  Today's Devotional summary (opens detail), quick actions (Tanya fAIth, Jurnal Doa), Nearby Churches teaser.
- **Priority**: Must

### FR-2: Chat (Tanya fAIth)
- Message list (user / assistant bubbles), text input + send button (disabled when empty), suggestion chips.
- Fake AI reply streamed with a typing effect (typing indicator → characters appear progressively), auto-scroll.
- States: empty (welcome + suggestions + recommended verse), loading reply, error (with retry), quota info
  "25 pesan/hari" shown statically.
- **Priority**: Must

### FR-3: Devotional (Renungan)
- List of daily devotionals (newest first) and detail: date, title, verse, reflection, prayer, today's challenge.
- Bookmark toggle (in-memory) and **Saved Devotionals** list with empty state; share button shows "Segera hadir".
- **Priority**: Must

### FR-4: Bible / Study (Alkitab)
- Study tab: search field (filters dummy books/topics), Today's Reading, Featured Study, Related Passages, Biblical Timeline.
- Reader: pick **book → chapter**, read verses, previous/next chapter, tap a verse to **mark** it
  (highlight + add to Favorite Verses). Dummy content limited to a few books/chapters.
- **Priority**: Must

### FR-5: Prayer Journal (Doa)
- Stats (active / answered), recent list, "Lihat semua" with search + filter (Semua/Aktif/Dijawab).
- Create, edit, delete, mark answered/active via form + bottom sheet; category chips. In-memory only.
- **Priority**: Must

### FR-6: Favorite Verses (Ayat Favorit)
- List, add, edit, delete, set default (default feeds Home encouragement card), empty state.
- **Priority**: Must

### FR-7: Settings & Profile (Pengaturan)
- Account card from real Auth (name, email, photo with initial fallback).
- Preferences: theme (Sistem/Terang/Gelap, applied live), language picker (Bahasa Indonesia/English — stored
  only, see Decision D2), notifications & daily reminder switches (local state), quota "25 pesan/hari" static.
- Links: Saved Devotionals, Favorite Verses, Spiritual Preferences, legal items ("Segera hadir").
- Profile screen: name/email (read-only in this phase), delete-account danger zone with confirm dialog (no-op + info).
- Logout via the existing `AuthController.signOut()`.
- **Priority**: Must

### FR-8: Nearby Churches (Gereja Terdekat)
- Dummy list (Indonesian churches/addresses, distance in km), map placeholder, "Petunjuk Arah" = "Segera hadir".
- **Priority**: Should

### FR-9: Polish
- Consistent page transitions, loading/empty/error states on every data screen, widget test per screen
  (renders with mock repo, light & dark, small screen + large text without overflow).
- **Priority**: Must

---

## Non-Functional Requirements
| Area | Requirement |
|------|-------------|
| Architecture | Feature-first: `features/<f>/{domain(models, repository interface), data(mock repo), presentation(controller, pages, widgets)}`. Controllers depend on interfaces only; bindings choose Mock impl. |
| Styling | No hardcoded colors/sizes in widgets: only `Theme`, `AppColors` via theme extension, `AppSpacing`, `AppRadius`. |
| Accessibility | Text ≥ 14sp; contrast OK in both themes; `Semantics`/tooltips on icon buttons; works at text scale 1.3 and 320dp width. |
| Copy | All UI copy and dummy data in Bahasa Indonesia. |
| Dependencies | **No new packages planned.** Icons: Material Icons; animation: Flutter built-ins. Any need is raised for approval first. |
| Quality | `flutter analyze` clean and `flutter test` green per bolt; one commit per bolt. |

## Constraints & Assumptions
- Built on branch `feat/phase-2-static-ui` from `chore/phase-1-cleanup` (feature-first structure).
- Firebase project migration (Phase 1 step E) still pending; Auth keeps using the current config meanwhile.
- Dummy Bible text: short placeholder samples only; the real Bible source + licensing (e.g. LAI TB is copyrighted)
  is decided in a later phase.

## Decisions (need approval)
| ID | Decision | Rationale |
|----|----------|-----------|
| D1 | Tabs follow prototype: Beranda, Tanya fAIth, Alkitab, Doa, Pengaturan | Matches prototype + requested features (Prayer, Settings); Devotional reachable from Home |
| D2 | UI copy fixed in Indonesian; language picker only stores the choice (no translation yet) | Same as prototype; real i18n is its own intent |
| D3 | Theme mode applied live but not persisted across restarts | Persistence needs a storage package → ask later (Phase 3) |
| D4 | Material Icons instead of Lucide | Avoid new dependency |
| D5 | Fix prototype bugs instead of porting them (back stack, prayer sheet from All Prayers, inert buttons → "Segera hadir") | Behavior quality |
| D6 | Add bolt 0 "ui-foundation" before Home | Shared tokens/widgets/shell needed by all screens |
