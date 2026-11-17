# Story 001-favorite-verses-crud — Favorite verses CRUD and default

**Intent:** 002-static-ui  
**Unit:** 007-favorite-verses  
**Priority:** Must  
**Status:** Draft

## Acceptance Criteria
- `FavoriteVerse{id, ref (bookId, chapter, verseStart, verseEnd?), translation, note?, isDefault, createdAt}`; text resolved via BibleRepository (D8)
-  exactly one default when the list is non-empty
- Add/edit form (pick book/chapter/verse + translation), delete with confirm, Set as default
- Default verse feeds the Home encouragement card
-  empty state
