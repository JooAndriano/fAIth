# Firestore Indexes (v1)

## Likely Queries

### `prayers`
- List current user's prayers newest-first:
  - where `uid == <currentUid>`
  - orderBy `createdAt desc`

**Composite index** (if console requires):
- Collection: `prayers`
- Fields: `uid` (ASC), `createdAt` (DESC)

### `chat_history`
- List current user's chats newest-first:
  - where `uid == <currentUid>`
  - orderBy `updatedAt desc` (or `createdAt desc`)

**Composite index**:
- Collection: `chat_history`
- Fields: `uid` (ASC), `updatedAt` (DESC)

### Optional: `saved_devotionals`
- List user's saved devotionals newest-first:
  - where `uid == <currentUid>`
  - orderBy `createdAt desc`

**Composite index**:
- Collection: `saved_devotionals`
- Fields: `uid` (ASC), `createdAt` (DESC)

## How to Create
- Firestore Console → Indexes → add composite index.
- Or capture index creation link from runtime error and follow it.
