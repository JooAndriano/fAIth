# Firestore Schema (v1)

## Conventions
- **Ownership**: private docs include `uid: string` (owner Firebase UID).
- **Timestamps**: `createdAt`, `updatedAt` are Firestore `timestamp`.

---

## 1) `users/{uid}` (private)
User profile + preferences.

**Doc ID**: `uid` (Firebase UID)

**Fields**
- `uid: string`
- `email: string?`
- `displayName: string?`
- `photoUrl: string?`
- `favoriteVerse: string?` (nullable)
- `language: string` (e.g. `id`, `en`)
- `darkMode: bool`
- `dailyMessages: number` (quota limit)
- `usedMessages: number` (quota used)
- `createdAt: timestamp`
- `updatedAt: timestamp`

---

## 2) `prayers/{prayerId}` (private)
User prayer log.

**Fields**
- `uid: string`
- `title: string?`
- `body: string`
- `tags: array<string>` (optional)
- `isAnswered: bool` (default false)
- `answeredAt: timestamp?`
- `createdAt: timestamp`
- `updatedAt: timestamp`

---

## 3) `chat_history/{chatId}` (private)
Conversation metadata + optional transcript pointer.

**Fields**
- `uid: string`
- `title: string?`
- `lastMessage: string?`
- `messageCount: number` (optional)
- `createdAt: timestamp`
- `updatedAt: timestamp`

(If storing messages later: prefer subcollection `chat_history/{chatId}/messages/{messageId}`.)

---

## 4) `saved_devotionals/{savedId}` (private)
Per-user saved items.

**Fields**
- `uid: string`
- `devotionalId: string` (ref to public devotional)
- `note: string?`
- `createdAt: timestamp`

---

## 5) `favorite_verses/{favId}` (private)
Per-user favorites.

**Fields**
- `uid: string`
- `reference: string` (e.g. `John 3:16`)
- `text: string?`
- `translation: string?`
- `createdAt: timestamp`

---

## 6) `daily_devotionals/{devotionalId}` (public read)
Curated content.

**Fields**
- `title: string`
- `body: string`
- `scriptureRefs: array<string>`
- `topicIds: array<string>` (optional)
- `publishedAt: timestamp`
- `createdAt: timestamp`
- `updatedAt: timestamp`

---

## 7) `featured_studies/{studyId}` (public read)
Curated studies.

**Fields**
- `title: string`
- `summary: string?`
- `content: string` (or structured later)
- `topicIds: array<string>`
- `publishedAt: timestamp`
- `createdAt: timestamp`
- `updatedAt: timestamp`

---

## 8) `reading_plans/{planId}` (public read)
Reading plan definitions.

**Fields**
- `title: string`
- `description: string?`
- `durationDays: number`
- `items: array<object>` (or subcollection later)
- `createdAt: timestamp`
- `updatedAt: timestamp`

---

## 9) `topics/{topicId}` (public read)
Topic taxonomy.

**Fields**
- `name: string`
- `slug: string`
- `description: string?`
- `createdAt: timestamp`
- `updatedAt: timestamp`
