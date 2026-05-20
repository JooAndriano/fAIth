# Implementation Plan: 004-firestore-structure

## Goal
Define stable Firestore data schema (9 collections), baseline security rules, and required indexes documentation.

## Scope
- 001-define-schema (Must)
- 002-security-rules (Must)
- 003-indexes (Should)

## Inputs / Existing Work
- Prior rules/spec: `memory-bank/bolts/002-firebase-setup/firestore-rules.md`
- Current auth profile sync writes: `fAIth_mobile/lib/app/services/auth_service.dart` (`users/{uid}` defaults)

## Target Collections (v1)
1. `users/{uid}` (private)
2. `prayers/{prayerId}` (private per-user)
3. `chat_history/{chatId}` (private per-user)
4. `saved_devotionals/{savedId}` (private per-user)
5. `favorite_verses/{favId}` (private per-user)
6. `daily_devotionals/{devotionalId}` (public content)
7. `featured_studies/{studyId}` (public content)
8. `reading_plans/{planId}` (public content)
9. `topics/{topicId}` (public content)

## Conventions (v1)
- Ownership: private docs include `uid` field == `request.auth.uid`.
- Timestamps:
  - Storage: Firestore `timestamp` type (serverTimestamp preferred).
  - App-facing display/logging: ISO 8601 strings.
  - Required fields: `createdAt`, `updatedAt` (timestamp).

## Deliverables
1. `schema.md` inside this bolt folder documenting collections/fields.
2. `security-rules.firestore` (or markdown w/ rules block) for v1 rules.
3. `indexes.md` documenting composite indexes likely needed.
4. `test-walkthrough.md` for manual + emulator checks.

## Steps
1. Draft schema doc for 9 collections (fields, types, ownership, timestamps).
2. Draft rules:
   - Default deny.
   - Private collections: allow read/write only if authed + owner.
   - Public collections: allow read true; writes false (admin only).
3. Identify queries → list composite indexes:
   - `prayers` by `uid` + `createdAt desc`
   - `chat_history` by `uid` + `createdAt desc`
   - (optional) `saved_devotionals` by `uid` + `createdAt desc`
4. Validate via emulator or Firebase Rules Playground:
   - owner reads allowed
   - cross-user denied
   - unauth denied for private
   - public reads allowed

## Acceptance Checklist
- All 9 collections documented
- Rules deny cross-user for `users/{uid}`, `prayers`, `chat_history`
- Indexes documented for likely queries
