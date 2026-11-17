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

### Intent: 002-static-ui

### Unit: 001-ui-foundation
- **001-theme-extension** - Status: Completed
  - Path: `memory-bank/intents/002-static-ui/units/001-ui-foundation/stories/001-theme-extension.md`
  - Description: Brand theme extension and theme-aware text
- **002-shared-widgets** - Status: Completed
  - Path: `memory-bank/intents/002-static-ui/units/001-ui-foundation/stories/002-shared-widgets.md`
  - Description: Shared UI widgets
- **003-view-state** - Status: Completed
  - Path: `memory-bank/intents/002-static-ui/units/001-ui-foundation/stories/003-view-state.md`
  - Description: ViewState and state widgets
- **004-shell-routes** - Status: Completed
  - Path: `memory-bank/intents/002-static-ui/units/001-ui-foundation/stories/004-shell-routes.md`
  - Description: Five-tab shell and sub-routes

### Unit: 002-home
- **001-home-data** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/002-home/stories/001-home-data.md`
  - Description: Home data contracts and mocks
- **002-home-screen** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/002-home/stories/002-home-screen.md`
  - Description: Home screen layout

### Unit: 003-chat
- **001-chat-domain** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/003-chat/stories/001-chat-domain.md`
  - Description: Chat models and fake AI repository
- **002-chat-screen** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/003-chat/stories/002-chat-screen.md`
  - Description: Chat screen
- **003-chat-states** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/003-chat/stories/003-chat-states.md`
  - Description: Typing effect and error handling

### Unit: 004-devotional
- **001-devotional-list-detail** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/004-devotional/stories/001-devotional-list-detail.md`
  - Description: Devotional list and detail
- **002-saved-devotionals** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/004-devotional/stories/002-saved-devotionals.md`
  - Description: Bookmark and saved devotionals

### Unit: 005-bible-study
- **001-study-tab** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/005-bible-study/stories/001-study-tab.md`
  - Description: Study tab
- **002-reader** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/005-bible-study/stories/002-reader.md`
  - Description: Book and chapter picker plus reader
- **003-mark-verse** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/005-bible-study/stories/003-mark-verse.md`
  - Description: Mark verse

### Unit: 006-prayer-journal
- **001-prayer-domain** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/006-prayer-journal/stories/001-prayer-domain.md`
  - Description: Prayer model and repository
- **002-prayer-journal-screen** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/006-prayer-journal/stories/002-prayer-journal-screen.md`
  - Description: Journal screen and form
- **003-prayer-actions** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/006-prayer-journal/stories/003-prayer-actions.md`
  - Description: All prayers and actions sheet

### Unit: 007-favorite-verses
- **001-favorite-verses-crud** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/007-favorite-verses/stories/001-favorite-verses-crud.md`
  - Description: Favorite verses CRUD and default

### Unit: 008-settings-profile
- **001-settings-screen** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/008-settings-profile/stories/001-settings-screen.md`
  - Description: Settings screen
- **002-preferences** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/008-settings-profile/stories/002-preferences.md`
  - Description: Theme and language
- **003-profile-logout** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/008-settings-profile/stories/003-profile-logout.md`
  - Description: Profile and logout

### Unit: 009-nearby-churches
- **001-churches-list** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/009-nearby-churches/stories/001-churches-list.md`
  - Description: Churches list

### Unit: 010-polish
- **001-transitions-states** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/010-polish/stories/001-transitions-states.md`
  - Description: Transitions and consistent states
- **002-widget-tests** - Status: Draft
  - Path: `memory-bank/intents/002-static-ui/units/010-polish/stories/002-widget-tests.md`
  - Description: Widget tests per screen
