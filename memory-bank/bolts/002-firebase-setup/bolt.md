---
id: 002-firebase-setup
unit: 002-firebase-setup
intent: 001-project-setup
type: simple-construction-bolt
status: planned
stories:
  - 001-firebase-project
  - 002-firestore-setup
  - 003-functions-setup
created: 2026-05-20T07:15:00Z
started: null
completed: null
current_stage: null
stages_completed: []
requires_bolts:
  - 001-flutter-project-init
enables_bolts:
  - 003-auth-flow
  - 004-firestore-structure
requires_units: []
blocks: false
complexity:
  avg_complexity: 2
  avg_uncertainty: 2
  max_dependencies: 3
  testing_scope: 2
---

# Bolt: 002-firebase-setup

## Overview
Link Flutter app to Firebase and scaffold Firestore + Functions.

## Objective
Enable Firebase Auth, Firestore, and Functions baseline for later app features.

## Stories Included
- **001-firebase-project**: Firebase Project Linkage (Must)
- **002-firestore-setup**: Firestore Setup (Must)
- **003-functions-setup**: Functions Setup (Should)

## Bolt Type
**Type**: simple-construction-bolt
**Definition**: `.specsmd/aidlc/templates/construction/bolt-types/simple-construction-bolt.md`

## Stages
- [ ] **1. Plan**: Pending → `implementation-plan.md`
- [ ] **2. Implement**: Pending → config/functions + `implementation-walkthrough.md`
- [ ] **3. Test**: Pending → Firebase init checks + `test-walkthrough.md`

## Dependencies
### Requires
- `001-flutter-project-init`

### Enables
- `003-auth-flow`
- `004-firestore-structure`

## Success Criteria
- [ ] Firebase configured for mobile app
- [ ] Firebase initializes without crash
- [ ] Functions TS scaffold builds
- [ ] Firestore collection schema documented/scaffolded
