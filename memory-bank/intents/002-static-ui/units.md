---
intent: 002-static-ui
phase: inception
status: units-decomposed
updated: 2026-11-16T14:45:00Z
---

# Static UI — Unit Decomposition

| Unit | FR | Description | Complexity | Depends on |
|------|----|-------------|------------|------------|
| 001-ui-foundation | FR-0 | Theme extension, shared widgets & ViewState, new 5-tab shell + sub-routes | M | — |
| 002-home | FR-1 | Beranda: greeting, encouragement, verse of the day, devotional summary, shortcuts | S | 001 |
| 003-chat | FR-2 | Tanya fAIth: messages, input, chips, fake streamed reply, states, quota note | M | 001 |
| 004-devotional | FR-3 | Renungan list/detail, bookmark, saved devotionals | S | 001 |
| 005-bible-study | FR-4 | Alkitab tab, book/chapter picker, reader, mark verse | L | 001, 007 (mark → favorites) |
| 006-prayer-journal | FR-5 | Jurnal Doa CRUD, stats, all prayers + filter, bottom sheet | M | 001 |
| 007-favorite-verses | FR-6 | Ayat Favorit CRUD + default verse | S | 001 |
| 008-settings-profile | FR-7 | Pengaturan, profile, theme, language, quota, logout | M | 001, 004, 007 |
| 009-nearby-churches | FR-8 | Gereja Terdekat dummy list + map placeholder | S | 001 |
| 010-polish | FR-9 | Transitions, consistent states, widget tests per screen | M | all |

## Dependency Graph
```text
001-ui-foundation ─┬─▶ 002-home ◀── (reads) 004, 007
                   ├─▶ 003-chat
                   ├─▶ 004-devotional
                   ├─▶ 006-prayer-journal
                   ├─▶ 007-favorite-verses ─▶ 005-bible-study
                   ├─▶ 008-settings-profile
                   └─▶ 009-nearby-churches ───────────────▶ 010-polish
```
Home reads devotional/favorite-verse/church repositories; their mock repos are created minimally in 002
and extended by their own bolts.
