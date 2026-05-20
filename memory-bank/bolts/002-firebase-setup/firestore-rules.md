# Firestore Security Rules & Structure

## Database Structure

### Collections

#### `users/{uid}`
User profile data. One document per authenticated user.

**Fields:**
```
{
  uid: string (document ID = Firebase UID)
  email: string
  displayName: string
  photoURL: string (optional)
  createdAt: timestamp
  updatedAt: timestamp
  quotaLimit: number (default: 100)
  quotaUsed: number (default: 0)
}
```

#### `quotas/{uid}`
User quota tracking. Mirrors quota data from `users/{uid}`.

**Fields:**
```
{
  uid: string (document ID = Firebase UID)
  limit: number
  used: number
  resetDate: timestamp
  lastUpdated: timestamp
}
```

#### `sessions/{sessionId}` (Optional)
Session tracking for multi-device support.

**Fields:**
```
{
  sessionId: string (document ID)
  uid: string
  deviceInfo: string
  createdAt: timestamp
  expiresAt: timestamp
  isActive: boolean
}
```

---

## Security Rules

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Helper functions
    function isAuthenticated() {
      return request.auth != null;
    }
    
    function isOwner(uid) {
      return request.auth.uid == uid;
    }
    
    function isValidUserData() {
      let data = request.resource.data;
      return data.size() > 0
        && 'email' in data
        && 'displayName' in data
        && 'createdAt' in data
        && 'updatedAt' in data;
    }
    
    function isValidQuotaData() {
      let data = request.resource.data;
      return data.size() > 0
        && 'uid' in data
        && 'limit' in data
        && 'used' in data
        && data.limit > 0
        && data.used >= 0
        && data.used <= data.limit;
    }
    
    // Users collection
    match /users/{uid} {
      // Read: User can read own profile
      allow read: if isAuthenticated() && isOwner(uid);
      
      // Create: User can create own profile on first sign-in
      allow create: if isAuthenticated() 
        && isOwner(uid)
        && isValidUserData()
        && request.resource.data.uid == uid;
      
      // Update: User can update own profile
      allow update: if isAuthenticated() 
        && isOwner(uid)
        && isValidUserData()
        && request.resource.data.uid == uid;
      
      // Delete: Disallow (use admin SDK for account deletion)
      allow delete: if false;
    }
    
    // Quotas collection
    match /quotas/{uid} {
      // Read: User can read own quota
      allow read: if isAuthenticated() && isOwner(uid);
      
      // Create: User can create own quota on first sign-in
      allow create: if isAuthenticated() 
        && isOwner(uid)
        && isValidQuotaData()
        && request.resource.data.uid == uid;
      
      // Update: User can update own quota (increment used)
      allow update: if isAuthenticated() 
        && isOwner(uid)
        && isValidQuotaData()
        && request.resource.data.uid == uid
        && request.resource.data.limit == resource.data.limit; // Prevent limit changes
      
      // Delete: Disallow
      allow delete: if false;
    }
    
    // Sessions collection (optional)
    match /sessions/{sessionId} {
      // Read: User can read own sessions
      allow read: if isAuthenticated() 
        && request.auth.uid == resource.data.uid;
      
      // Create: User can create own session
      allow create: if isAuthenticated() 
        && request.auth.uid == request.resource.data.uid
        && 'sessionId' in request.resource.data
        && 'deviceInfo' in request.resource.data
        && 'createdAt' in request.resource.data
        && 'expiresAt' in request.resource.data;
      
      // Update: User can update own session (mark inactive)
      allow update: if isAuthenticated() 
        && request.auth.uid == resource.data.uid;
      
      // Delete: User can delete own session
      allow delete: if isAuthenticated() 
        && request.auth.uid == resource.data.uid;
    }
    
    // Deny all other access
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

---

## Deployment

### Deploy Rules via Firebase CLI
```bash
firebase deploy --only firestore:rules
```

### Verify Rules in Console
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select `fAIth` project
3. Navigate to **Firestore** → **Rules**
4. Confirm rules are deployed

---

## Testing Rules

### Test Cases

#### ✅ Authenticated User - Read Own Profile
```
User: uid=user123
Request: Read /users/user123
Expected: ALLOW
```

#### ❌ Authenticated User - Read Other Profile
```
User: uid=user123
Request: Read /users/user456
Expected: DENY
```

#### ✅ Authenticated User - Create Own Profile
```
User: uid=user123
Request: Create /users/user123 with valid data
Expected: ALLOW
```

#### ❌ Unauthenticated - Read Profile
```
User: null
Request: Read /users/user123
Expected: DENY
```

#### ✅ Authenticated User - Update Own Quota
```
User: uid=user123
Request: Update /quotas/user123 (increment used)
Expected: ALLOW
```

#### ❌ Authenticated User - Change Quota Limit
```
User: uid=user123
Request: Update /quotas/user123 (change limit)
Expected: DENY
```

---

## Notes

- **Spark Plan Limits**: 1 GB storage, 50K reads/day, 20K writes/day
- **Security First**: All rules enforce authentication + ownership
- **Quota Protection**: Users cannot modify their quota limit (server-side only)
- **Session Tracking**: Optional; useful for multi-device support
- **Admin SDK**: Use for account deletion, batch operations, admin tasks
