# Implementation Walkthrough: 003-auth-flow

## Summary
Implemented Google Sign-In auth flow using Firebase Auth, Firestore profile sync, persistent session state, route guards, and sign-out.

## Files Changed
- `lib/main.dart`
- `lib/app/bindings/app_bindings.dart`
- `lib/app/services/auth_service.dart`
- `lib/app/controllers/auth_controller.dart`
- `lib/app/routes/auth_middleware.dart`
- `lib/app/routes/app_routes.dart`
- `lib/app/pages/splash/splash_page.dart`
- `lib/app/pages/auth/login_page.dart`
- `lib/app/pages/profile/profile_page.dart`

## Implementation Details

### Firebase Init
`main.dart` initializes Firebase before app startup using generated `firebase_options.dart`.

### Dependency Binding
`AppBindings` registers `AuthController` as permanent GetX dependency.

### Auth Service
`AuthService` handles:
- Google Sign-In
- Firebase credential exchange
- Profile sync to Firestore `users/{uid}`
- Sign-out from Google + Firebase

### Profile Sync
First login creates:
- `uid`
- `email`
- `displayName`
- `photoUrl`
- `createdAt`
- `updatedAt`
- `favoriteVerse`
- `language`
- `darkMode`
- `dailyMessages`
- `usedMessages`

Subsequent logins update only non-destructive identity fields:
- `email`
- `displayName`
- `photoUrl`
- `updatedAt`

### Session
`AuthController` listens to `FirebaseAuth.authStateChanges()`.
This persists signed-in state after app restart via Firebase SDK.

### Routing
Protected pages use `AuthMiddleware`:
- `/shell`
- `/home`
- `/chat`
- `/study`
- `/devotional`
- `/profile`

Unauthenticated access redirects to `/login`.

### Splash
Splash waits briefly, then routes:
- authenticated → `/shell`
- unauthenticated → `/login`

### Login
Login button calls `AuthController.signInWithGoogle()` and routes to `/shell` on success.
Cancelled sign-in stays on login.

### Sign-out
Profile page includes sign-out button:
- clears Google session
- clears Firebase session
- routes to `/login`

## Notes
- `firebase_options.dart` must exist from FlutterFire CLI.
- Android package must match Firebase app package: `com.faith.app`.
- SHA-1/SHA-256 may be required in Firebase console for Google Sign-In on Android.
