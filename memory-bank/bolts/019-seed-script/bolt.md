---
id: 019-seed-script
unit: 003-seed-script
intent: 003-firestore-integration
type: simple-construction-bolt
status: completed
stories: []
created: 2026-11-17T08:00:00Z
started: 2026-11-17T08:00:00Z
completed: 2026-11-17T08:45:00Z
current_stage: done
stages_completed: [implement, test]
requires_bolts: []
---

# Bolt: 019-seed-script

Intent 003 bolt #3 of 8 (global ids 017–024: 017 schema audit, 018 rules + emulator tests,
**019 seed script**, 020 Firestore repos, 021 chat repo, 022 Bible pipeline, 023 content-gen,
024 deploy + e2e). Built ahead of 017/018 at the user's request; intent 003 inception docs
(requirements, stories) are not written yet.

## Objective
Admin SDK script that seeds reviewed (published) devotionals from `content/devotionals/*.json`.

## Definition of Done
- `tools/seed/` (Node 20+, firebase-admin) with own package.json + README.
- Only `status: "published"` written; flags `--project`, `--emulator`, `--dry-run`.
- Idempotent: doc id `day-NNN` from `dayNumber`; unchanged docs skipped.
- Credentials only via `GOOGLE_APPLICATION_CREDENTIALS`; no key in repo.
- `npm test` green.

## Result
- `tools/seed/lib.mjs` (validation, doc id, content compare), `seed-devotionals.mjs` (CLI),
  `lib.test.mjs` (8 node:test cases).
- Validates all files before any write; one batch commit; `createdAt` set once, `updatedAt` on change.
- Guards: refuses key inside repo, key `project_id` ≠ `--project`, or stray `FIRESTORE_EMULATOR_HOST`
  without `--emulator`. Drafts that exist remotely are warned about, never deleted.
- Sample content: `content/devotionals/day-001` (published), `day-002..004` (draft); `verseText` is a
  `[CONTOH]` placeholder until the AYT asset exists (bolt 022).

## Open points (for 017/018)
- Collection name: script writes `devotionals` (Phase 3 brief); current `firestore.rules`/schema v0
  still use `daily_devotionals`, so clients cannot read `devotionals` until bolt 018 updates rules.
- Emulator run not verified: firebase-tools 15 requires Java 21 (machine has 17).
