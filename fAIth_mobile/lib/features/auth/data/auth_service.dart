import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final GoogleSignIn _google;

  AuthService({
    FirebaseAuth? auth,
    FirebaseFirestore? db,
    GoogleSignIn? google,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _db = db ?? FirebaseFirestore.instance,
        _google = google ?? GoogleSignIn();

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> signInWithGoogle() async {
    // Start interactive sign-in flow
    final GoogleSignInAccount? googleUser = await _google.signIn();
    if (googleUser == null) return null; // cancelled

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCred = await _auth.signInWithCredential(credential);
    final user = userCred.user;
    if (user != null) {
      await syncUserProfile(user);
    }
    return userCred;
  }

  Future<void> signOut() async {
    // Order: Google then Firebase
    await _google.signOut();
    await _auth.signOut();
  }

  Future<void> syncUserProfile(User user) async {
    final docRef = _db.collection('users').doc(user.uid);
    final now = FieldValue.serverTimestamp();

    final base = <String, dynamic>{
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoUrl': user.photoURL,
      'updatedAt': now,
    };

    // Check if document exists
    final snap = await docRef.get();

    if (!snap.exists) {
      // Create new user profile with defaults
      await docRef.set({
        ...base,
        'createdAt': now,
        'favoriteVerse': null,
        'language': 'id',
        'darkMode': false,
        'dailyMessages': 5,
        'usedMessages': 0,
      });
    } else {
      // Non-destructive update: only update user identity fields + updatedAt
      await docRef.update(base);
    }
  }
}
