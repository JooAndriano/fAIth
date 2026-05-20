# Story 002 — Profile Sync

**Intent:** 001-project-setup
**Unit:** 003-auth-flow
**Story:** 002-profile-sync
**Status:** Draft

## User Story
As a user, I want my profile saved on first login so preferences/quota can be tracked.

## Acceptance Criteria
- On first login: create `users/{uid}`.
- On subsequent logins: update non-destructive fields (name/photoUrl).
- Default fields set if missing: `favoriteVerse`, `language`, `darkMode`, `dailyMessages`, `usedMessages`.
