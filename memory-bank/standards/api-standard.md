# API & Data Standard

## API Structure
- Use RESTful for HTTP APIs
- /users, /prayers, /verses, etc.
- GET/POST/PUT/DELETE verbs as appropriate
- No direct Gemini access from client; proxy via Firebase Functions

## Data Contracts
- JSON [RcamelCase keys (e.g., `favoriteVerse`)
- Use ISO 8601 for timestamps
- Include explicit version in API paths (e.g., `/v1/`)

## Auth
- Bearer token via Firebase Auth (ID token in header)

---

**Status:** Accepted
**Date:** 2026-05-20
