# Implementation Plan: 003-auth-flow

## Goal
Google Sign-In + session persistence + profile sync (`users/{uid}`) using Firebase Auth + Firestore.

## Scope (Must)
- 001-google-signin
- 002-profile-sync
- 003-session

## Prereqs
- Firebase configured (bolt 002)
- `google-services.json` present (Android)
- `flutterfire configure` executed → generates `lib/firebase_options.dart`

## Design
- `AuthService` wraps FirebaseAuth + GoogleSignIn + Firestore.
- `AuthController` (GetX) exposes reactive `user` + `isLoading` + signIn/signOut.
- Route guard via GetX `GetMiddleware` (redirect to `/login` when unauth).
- Splash decides initial route based on current auth state.

## Steps
1. Ensure `lib/firebase_options.dart` exists (run `flutterfire configure`).
2. Update `main.dart` → `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`.
3. Add `AuthService`:
   - `signInWithGoogle()`
   - `signOut()`
   - `syncUserProfile(User)` create/update `users/{uid}` with defaults.
4. Add `AuthController`:
   - bind `FirebaseAuth.instance.authStateChanges()`
   - expose `isAuthenticated`.
5. Add `AuthMiddleware`:
   - protect `/shell`, `/home`, `/chat`, `/study`, `/devotional`, `/profile`.
6. Update `AppRoutes.pages` to apply middleware.
7. Update `SplashPage` → route to `/shell` if signed in else `/login`.
8. Update `LoginPage` button → call controller.signInWithGoogle(); on success go `/shell`.
9. Add minimal `ProfilePage` display (email/uid) + sign out button.
10. Test flow.

## Acceptance Checklist
- Sign-in works/cancel handled
- Profile doc created/updated
- Session persists after restart
- Sign-out clears + back to login
- Guard blocks unauth access
