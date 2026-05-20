# Test Walkthrough: 004-firestore-structure

## Manual Checklist

### 1. Schema Review
- Confirm 9 collections documented in `schema.md`.
- Confirm private vs public classification matches intent.

### 2. Rules Logic (Playground/Emulator)
Test with 2 users: `uidA`, `uidB`.

#### Users
- `uidA` read `/users/uidA` → ALLOW
- `uidA` read `/users/uidB` → DENY
- unauth read `/users/uidA` → DENY

#### Prayers
- `uidA` create `/prayers/x` with `{uid:"uidA"}` → ALLOW
- `uidA` create `/prayers/x` with `{uid:"uidB"}` → DENY
- `uidB` read `/prayers/x` owned by `uidA` → DENY

#### Chat History
- Same as prayers (owner-only).

#### Public content
- unauth read `/topics/*` → ALLOW
- authed write `/topics/*` → DENY

### 3. Index Expectations
- Run sample query (if implemented later) with where(uid)+orderBy(createdAt) and capture any missing-index error link.

## Expected Result
- Cross-user access denied for private collections.
- Private collections require auth.
- Public content readable without auth, not writable.
