# Implementation Plan: 002-firebase-setup (Spark Plan - No Functions)

## Overview
Setup Firebase project with Firestore and Authentication, using **Spark (free) plan**. Cloud Functions skipped for now.

## Scope
**Must-Have Stories:**
- `001-firebase-init`: Firebase project linkage + CLI setup
- `002-firestore-rules`: Firestore security rules + structure

**Skipped (Requires Blaze plan):**
- `003-functions-setup`: Cloud Functions (deferred)

## Prerequisites
- Flutter project initialized (`001-flutter-project-init` completed)
- Firebase account (Google)
- Firebase CLI installed locally
- Node.js + npm (for firebase-tools)

## Implementation Steps

### Phase 1: Firebase Project Setup
1. **Create Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create new project: `fAIth`
   - Select **Spark (free) plan**
   - Enable Google Analytics (optional)

2. **Enable Required Services**
   - Enable **Authentication** (Google Sign-In provider)
   - Enable **Firestore Database** (test mode initially)
   - Enable **Cloud Storage** (optional, for profile images)

3. **Download Service Account Key** (optional, for backend use)
   - Project Settings → Service Accounts → Generate new private key
   - Save as `firebase-key.json` (add to `.gitignore`)

### Phase 2: Local Firebase CLI Setup
1. **Install Firebase CLI**
   ```bash
   npm install -g firebase-tools
   ```

2. **Authenticate**
   ```bash
   firebase login
   ```

3. **Initialize Firebase in Flutter Project**
   ```bash
   firebase init
   ```
   - Select: Firestore, Authentication, Storage (if needed)
   - Link to `fAIth` project
   - Accept default configurations

### Phase 3: Firestore Structure & Rules
1. **Create Firestore Collections**
   - `users/{uid}` - User profiles
   - `quotas/{uid}` - User quota tracking
   - `sessions/{sessionId}` - Session data (optional)

2. **Set Security Rules**
   - Users can read/write own documents only
   - Authenticated users only
   - See `firestore-rules.md` for detailed rules

3. **Deploy Rules**
   ```bash
   firebase deploy --only firestore:rules
   ```

### Phase 4: Flutter Integration
1. **Add Firebase Dependencies**
   - `firebase_core`
   - `firebase_auth`
   - `cloud_firestore`
   - `google_sign_in`

2. **Initialize Firebase in App**
   - Call `Firebase.initializeApp()` in `main()`
   - Configure Google Sign-In

3. **Test Authentication Flow**
   - Verify Google Sign-In works
   - Verify Firestore read/write permissions

## Success Criteria
- [ ] Firebase project created (Spark plan)
- [ ] Firestore enabled and accessible
- [ ] Authentication (Google Sign-In) configured
- [ ] Security rules deployed
- [ ] Flutter app connects to Firebase
- [ ] Test user can authenticate and write to Firestore

## Timeline
- **Phase 1**: 15 min (Firebase Console setup)
- **Phase 2**: 10 min (CLI + local init)
- **Phase 3**: 15 min (Firestore structure + rules)
- **Phase 4**: 20 min (Flutter integration + testing)
- **Total**: ~60 minutes

## Next Steps
1. Complete Phase 1 (Firebase Console)
2. Confirm project creation
3. Proceed to Phase 2 (CLI setup)
4. Generate `firestore-rules.md` with detailed security rules
5. Generate `implementation-walkthrough.md` with code examples

## Notes
- Spark plan has limits: 1 GB storage, 50K reads/day, 20K writes/day
- Sufficient for development/testing
- Upgrade to Blaze when ready for Cloud Functions (bolt `003-functions-setup`)
- All credentials stored in `.gitignore` files
