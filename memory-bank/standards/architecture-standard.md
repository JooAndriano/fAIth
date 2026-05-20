# Architecture Standard

## App Layers
- Presentation (Flutter UI w/ GetX)
- Domain (logic, models)
- Data (repositories, sources, DTOs)
- Service (Firebase Functions, Firestore)

## Rules
- No business logic in widgets
- Use Dependency Injection via GetX
- Favor immutability
- Write unit tests for all logic layers

## Folder Structure Suggestion
```
lib/
  features/
  core/
  shared/
```

## Testing
- 100% coverage goal for domain logic
- Automated UI tests for critical flows

---

**Status:** Accepted
**Date:** 2026-05-20
