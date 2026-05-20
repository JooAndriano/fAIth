# System Context — Intent 001: Project Setup

**Intent:** 001-project-setup
**Status:** Draft
**Created:** 2026-05-20T07:10:00Z

## System Under Design
**fAIth Mobile App** (`fAIth_mobile/`) — Flutter + GetX client integrated with Firebase backend services.

## Actors
- **End User** (Human): Christian users using mobile app for chat, study, devotionals, prayers.
- **Developer** (Human): Sets up local dev, runs emulators, deploys Functions.
- **Firebase Platform** (System): Auth/Firestore/Functions/Storage/FCM runtime.

## External Systems
- **Google Sign-In** (Inbound auth): OAuth via Firebase Auth (Google provider).
- **Firestore** (Both): User profile + app data persistence.
- **Firebase Functions** (Inbound/Outbound): HTTPS callable/HTTP endpoints consumed by mobile app; later calls Gemini.
- **Firebase Storage** (Outbound): Media assets (future: user uploads).
- **Firebase Cloud Messaging** (Outbound): Push notifications (future phases).
- **Gemini Flash API** (Outbound via Functions only): AI responses; never called from client.

## Data Flows
### Inbound (to Mobile)
- User input (login taps, chat messages, prayer entries, settings changes).
- Auth state updates (Firebase Auth).
- Firestore snapshots (user doc, chat/prayer history).

### Outbound (from Mobile)
- Auth requests (Google Sign-In via Firebase).
- Reads/writes to Firestore (profile, chat_history, prayers, favorites, devotionals cache).
- Calls to Functions endpoints (AI proxy placeholder in this intent).

## Context Diagram
```mermaid
C4Context
    title System Context - fAIth (Intent 001: Project Setup)

    Person(user, "End User", "Uses fAIth to chat/study/devotional/prayer")
    Person(dev, "Developer", "Runs Flutter, config Firebase, deploy Functions")

    System(app, "fAIth Mobile App", "Flutter + GetX client")

    System_Ext(google, "Google Sign-In", "OAuth identity provider")
    System_Ext(firebase, "Firebase", "Auth, Firestore, Functions, Storage, FCM")
    System_Ext(gemini, "Gemini Flash API", "AI model API (server-side only)")

    Rel(user, app, "Uses")
    Rel(dev, app, "Builds/runs")
    Rel(app, google, "Sign-in", "OAuth via Firebase Auth")
    Rel(app, firebase, "Reads/writes/calls", "SDK (Firestore/Auth/Functions)")
    Rel(firebase, gemini, "Calls", "HTTPS (Functions only)")
```

## Open Questions / Future Integrations
- Maps provider for Nearby Churches (Google Maps vs other) — Phase 2/3.
- Notifications rules + scheduling strategy — Phase 6.
