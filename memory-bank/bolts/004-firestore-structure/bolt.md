---
id: 004-firestore-structure
unit: 004-firestore-structure
intent: 001-project-setup
type: simple-construction-bolt
status: planned
stories:
  - 001-define-schema
  - 002-security-rules
  - 003-indexes
created: 2026-05-20T07:15:00Z
started: null
completed: null
current_stage: null
stages_completed: []
requires_bolts:
  - 001-flutter-project-init
  - 002-firebase-setup
enables_bolts: []
requires_units: []
blocks: false
complexity:
  avg_complexity: 2
  avg_uncertainty: 1
  max_dependencies: 3
  testing_scope: 2
---

# Bolt: 004-firestore-structure

## Overview
Define Firestore schema, security rules, and indexes.

## Objective
Establish stable data layer with correct access control for core collections.

## Stories Included
- **001-define-schema**: Define Schema (Must)
- **002-security-rules**: Security Rules (Must)
- **003-indexes**: Indexes (Should)

## Bolt Type
**Type**: simple-construction-bolt
**Definition**: `.specsmd/aidlc/templates/construction/bolt-types/simple-construction-bolt.md`

## Stages
- [ ] **1. Plan**: Pending → `implementation-plan.md`
- [ ] **2. Implement**: Pending → schema/rules/indexes + `implementation-walkthrough.md`
- [ ] **3. Test**: Pending → rules validation + `test-walkthrough.md`

## Dependencies
### Requires
- `001-flutter-project-init`
- `002-firebase-setup`

### Enables
- None

## Success Criteria
- [ ] All 9 collections scaffolded/documented
- [ ] Security rules prevent cross-user access
- [ ] Indexes defined for common queries