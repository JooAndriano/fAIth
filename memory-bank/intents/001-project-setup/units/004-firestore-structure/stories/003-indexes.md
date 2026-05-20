# Story 003 — Indexes

**Intent:** 001-project-setup
**Unit:** 004-firestore-structure
**Story:** 003-indexes
**Status:** Draft

## User Story
As a developer, I want required Firestore indexes defined so queries don’t fail in production.

## Acceptance Criteria
- Identify likely queries (by uid + createdAt) for `prayers`, `chat_history`.
- Add index definitions as needed (documented even if created later in console).
