# Story Index

Master index of all stories across the fAIth project.

This file tracks all user stories, acceptance criteria, and their status across all intents and units.

## Format

Stories are organized by intent and unit:

```
## Intent: {intent-name}

### Unit: {unit-name}

- **{SSS}-{story-title}** - Status: [Pending | In Progress | Completed]
  - Path: `memory-bank/intents/{intent-name}/units/{unit-name}/stories/{SSS}-{story-title}.md`
  - Description: Brief description
```

## Stories

### Intent: 001-project-setup

### Unit: 001-flutter-project-init
- **S001-setup-flutter-project** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/001-flutter-project-init/stories/001-setup-flutter-project.md`
  - Description: Create Flutter app scaffold (fAIth_mobile)
- **S002-add-getx** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/001-flutter-project-init/stories/002-add-getx.md`
  - Description: Add GetX dependency, setup routing skeleton
- **S003-setup-lint** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/001-flutter-project-init/stories/003-setup-lint.md`
  - Description: Add analysis_options.yaml and lint rules

### Unit: 002-firebase-setup
- **S001-firebase-project** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/002-firebase-setup/stories/001-firebase-project.md`
  - Description: Link Firebase project, configure Android/iOS apps
- **S002-firestore-setup** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/002-firebase-setup/stories/002-firestore-setup.md`
  - Description: Create base Firestore collections and rules
- **S003-functions-setup** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/002-firebase-setup/stories/003-functions-setup.md`
  - Description: Initialize Firebase Functions (TypeScript) and deploy skeleton

### Unit: 003-auth-flow
- **S001-google-signin** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/003-auth-flow/stories/001-google-signin.md`
  - Description: Implement Google Sign-In, handle tokens
- **S002-profile-sync** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/003-auth-flow/stories/002-profile-sync.md`
  - Description: Persist basic user profile in Firestore under users/{uid}
- **S003-session** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/003-auth-flow/stories/003-session.md`
  - Description: Manage session state and signout

### Unit: 004-firestore-structure
- **S001-define-schema** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/004-firestore-structure/stories/001-define-schema.md`
  - Description: Document field definitions for users, devotions, prayers, chat_history
- **S002-security-rules** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/004-firestore-structure/stories/002-security-rules.md`
  - Description: Write Firestore security rules for user data
- **S003-indexes** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/004-firestore-structure/stories/003-indexes.md`
  - Description: Create required Firestore indexes

### Unit: 005-navigation-setup
- **S001-shell** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/005-navigation-setup/stories/001-shell.md`
  - Description: Create navigation shell with BottomNavigationBar
- **S002-routes** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/005-navigation-setup/stories/002-routes.md`
  - Description: Define typed routes and route guards for auth
- **S003-shell-states** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/005-navigation-setup/stories/003-shell-states.md`
  - Description: Manage shell state and selected tab persistence

### Unit: 006-design-system-base
- **S001-theme** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/006-design-system-base/stories/001-theme.md`
  - Description: Define ThemeData with primary, accent, background colors
- **S002-typography** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/006-design-system-base/stories/002-typography.md`
  - Description: Define text styles and scale
- **S003-core-widgets** - Status: Draft
  - Path: `memory-bank/intents/001-project-setup/units/006-design-system-base/stories/003-core-widgets.md`
  - Description: Create Button, Card, ListItem components

---

**Last Updated:** 2026-05-20T07:15:00Z
**Mode:** single-file
