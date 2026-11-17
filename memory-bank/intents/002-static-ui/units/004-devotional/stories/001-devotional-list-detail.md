# Story 001-devotional-list-detail — Devotional list and detail

**Intent:** 002-static-ui  
**Unit:** 004-devotional  
**Priority:** Must  
**Status:** Draft

## Acceptance Criteria
- `Devotional{id, dayNumber, title, verseRef, verseText, body, reflectionQuestions[], prayer, tags[], status}` (D7); mock exposes only `published`
- List by day number (newest first) with first tag
-  detail shows verse, body, Pertanyaan Refleksi, Doa
- Share button shows "Segera hadir" snackbar
