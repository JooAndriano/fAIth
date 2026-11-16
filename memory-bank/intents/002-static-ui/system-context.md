---
intent: 002-static-ui
phase: inception
status: draft
updated: 2026-11-16T14:45:00Z
---

# System Context — Intent 002: Static UI

## Context Diagram
```text
          ┌──────────────┐  Google Sign-In (real)   ┌──────────────────┐
  User ──▶│ fAIth_mobile │ ───────────────────────▶ │ Firebase Auth    │
          │  Flutter UI  │                          └──────────────────┘
          │  GetX ctrl   │──▶ Abstract repositories ──▶ Mock*Repository (in-memory, ID dummy data)
          └──────────────┘          │
                                    └─ Phase 3: Firestore*Repository / Functions (AI) — out of scope
```

## External Systems
| System | Use in this intent |
|--------|--------------------|
| Firebase Auth | Real: current user (name, email, photo), sign-out |
| Firestore | Not used (repositories are mocked) |
| Gemini via Functions | Not used (fake streamed reply) |
| Maps / Location | Not used (placeholder) |

## Reference
- Visual & flow reference: `fAIth_web/src/app/components/*Screen.tsx`, tokens in `fAIth_web/src/styles/theme.css`.
- Existing Flutter base: `lib/core/theme/*`, `lib/shared/widgets/*`, `lib/features/shell`, `lib/features/auth`.

## Layering per feature
```text
features/<feature>/
  domain/        models (immutable, copyWith), <Feature>Repository (abstract)
  data/          Mock<Feature>Repository (simulated latency, Indonesian dummy data)
  presentation/  <Feature>Controller (GetX, depends on interface), pages/, widgets/
core/bindings    binds interface -> Mock impl (single place to switch in Phase 3)
```
