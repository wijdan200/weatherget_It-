import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterweather/features/data/datasource/auth_preferences_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: '387409165601-opsl9cit93e5b56pulihvks9va12923a.apps.googleusercontent.com',
  );
  final AuthPreferencesService _authPreferences;

  AuthService(this._authPreferences);

  // Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Auth state stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Save auth state to shared preferences
      if (credential.user != null) {
        await _saveAuthStateToPreferences(credential.user!);
      }
      
      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception('An error occurred: ${e.toString()}');
    }
  }

  // Sign up with email and password
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Save auth state to shared preferences
      if (credential.user != null) {
        await _saveAuthStateToPreferences(credential.user!);
      }
      
      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception('An error occurred: ${e.toString()}');
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        return null; // User canceled
      }

      // Obtain auth details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      if (googleAuth.idToken == null) {
        throw Exception('ID token is null. Check SHA-1: FB:C6:60:11:C7:81:E0:D1:4D:8E:08:7D:EC:FB:25:C0:6C:DC:F6:5D');
      }

      // Create credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      // Save auth state
      if (userCredential.user != null) {
        final user = userCredential.user!;
        await _saveAuthStateToPreferences(
          user,
          authProvider: 'google',
          name: googleUser.displayName ?? user.displayName,
          photoUrl: googleUser.photoUrl ?? user.photoURL,
        );
      }
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception('Google Sign-In error: ${e.toString()}');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        _authPreferences.clearAuthState(),
      ]);
    } catch (e) {
      // Try to sign out from each service individually if Future.wait fails
      try {
        await _firebaseAuth.signOut();
      } catch (_) {}
      try {
        await _googleSignIn.signOut();
      } catch (_) {}
      try {
        await _authPreferences.clearAuthState();
      } catch (_) {}
      // Re-throw the original exception
      throw Exception('Sign out error: ${e.toString()}');
    }
  }

  // Save auth state to shared preferences
  Future<void> _saveAuthStateToPreferences(
    User user, {
    String? authProvider,
    String? name,
    String? photoUrl,
  }) async {
    try {
      await _authPreferences.saveAuthState(
        userId: user.uid,
        email: user.email ?? '',
        name: name ?? user.displayName,
        photoUrl: photoUrl ?? user.photoURL,
        authProvider: authProvider ?? user.providerData.firstOrNull?.providerId ?? 'email',
      );
    } catch (e) {
      // Log error but don't throw - saving preferences shouldn't fail the auth flow
      debugPrint("Error saving auth state to preferences: $e");
    }
  }

  // Get auth state from shared preferences
  Future<Map<String, dynamic>> getAuthStateFromPreferences() async {
    return await _authPreferences.getAuthData();
  }

  // Check if user is logged in from preferences
  Future<bool> isLoggedInFromPreferences() async {
    return await _authPreferences.isLoggedIn();
  }

  // Handle auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled. Please enable Google Sign-In in Firebase Console under Authentication > Sign-in method.';
      default:
        return e.message ?? 'An unknown error occurred.';
    }
  }
}

