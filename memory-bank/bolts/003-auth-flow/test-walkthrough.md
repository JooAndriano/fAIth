# Test Walkthrough: 003-auth-flow

## Manual Test Checklist

### 1. Launch App
- Open app
- Splash visible
- If signed out → goes to `/login`
- If signed in previously → goes to `/shell`

### 2. Google Sign-In
- Tap `Sign in with Google`
- Select account
- Success → route to `/shell`
- Cancel → remains on login
- Failure → no crash

### 3. Profile Sync
After first successful login, verify Firestore `users/{uid}` exists with:
- `uid`
- `email`
- `displayName`
- `photoUrl`
- `favoriteVerse`
- `language`
- `darkMode`
- `dailyMessages`
- `usedMessages`
- timestamps

On second login, verify profile updates non-destructively.

### 4. Session Persistence
- Sign in
- Close app completely
- Reopen app
- Expect direct route to `/shell`

### 5. Route Guard
- While signed out, try navigating to protected page
- Expect redirect to `/login`

### 6. Sign-out
- Open profile tab/page
- Tap `Sign out`
- Expect route to `/login`
- Reopen app → should remain signed out

## Expected Result
All auth acceptance criteria pass.

## Known External Dependencies
- Valid Firebase Android app config
- `google-services.json`
- `firebase_options.dart`
- SHA fingerprint configured for Android Google Sign-In
