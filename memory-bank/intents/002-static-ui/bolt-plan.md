---
intent: 002-static-ui
phase: inception
status: draft
updated: 2026-11-16T14:45:00Z
---

# Bolt Plan — Intent 002: Static UI

Bolt ids continue the global sequence after intent 001 (001–006). One bolt = one unit = one commit;
`flutter analyze` clean + `flutter test` green before each commit.

| Bolt | Unit | Goal | Stories |
|------|------|------|---------|
| 007-ui-foundation | 001-ui-foundation | Tokens/theme extension, shared widgets, ViewState, new shell & routes | 001–004 |
| 008-home | 002-home | Beranda screen | 001–002 |
| 009-chat | 003-chat | Tanya fAIth screen | 001–003 |
| 010-devotional | 004-devotional | Renungan list/detail/saved | 001–002 |
| 011-bible-study | 005-bible-study | Alkitab tab + reader + mark verse | 001–003 |
| 012-prayer-journal | 006-prayer-journal | Jurnal Doa CRUD | 001–003 |
| 013-favorite-verses | 007-favorite-verses | Ayat Favorit CRUD | 001 |
| 014-settings-profile | 008-settings-profile | Pengaturan + Profil | 001–003 |
| 015-nearby-churches | 009-nearby-churches | Gereja Terdekat | 001 |
| 016-polish | 010-polish | Transitions, states, tests | 001–002 |

Order follows the requested sequence; 013 (favorite verses) is built before 011's "mark verse" wiring
is finalized — if 011 runs first, marking writes through the FavoriteVerseRepository interface with the
minimal mock from 008.
