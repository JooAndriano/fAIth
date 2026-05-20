# Story 002 — Security Rules

**Intent:** 001-project-setup
**Unit:** 004-firestore-structure
**Story:** 002-security-rules
**Status:** Draft

## User Story
As a user, I want my data private so other users cannot access it.

## Acceptance Criteria
- Firestore rules deny cross-user access for:
  - `users/{uid}`
  - `prayers/{doc}` (owned by uid)
  - `chat_history/{doc}` (owned by uid)
- Rules require auth for private reads/writes.
