# Story 001-prayer-domain — Prayer model and repository

**Intent:** 002-static-ui  
**Unit:** 006-prayer-journal  
**Priority:** Must  
**Status:** Draft

## Acceptance Criteria
- `Prayer{id, title, note, category, createdAt, answered}`
-  categories Kesehatan, Keluarga, Tuntunan, Keuangan, Teman, Gereja, Pribadi, Misi, Lainnya
- `PrayerRepository` CRUD plus watch stream
-  Mock with ~10 Indonesian samples
