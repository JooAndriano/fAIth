# Story 002 — Firestore Setup

**Intent:** 001-project-setup
**Unit:** 002-firebase-setup
**Story:** 002-firestore-setup
**Status:** Draft

## User Story
As a developer, I want Firestore collections scaffolded so later features have a stable data shape.

## Acceptance Criteria
- Collections scaffolded/docs present:
  - `users`, `daily_devotionals`, `featured_studies`, `reading_plans`, `topics`,
    `saved_devotionals`, `favorite_verses`, `prayers`, `chat_history`.
- `users/{uid}` schema includes quota: `dailyMessages` default 25, `usedMessages` default 0.
