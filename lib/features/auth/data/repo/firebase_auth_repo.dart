import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/enum/user.dart';
import '../models/app_user.dart';
import 'auth_repo.dart';

class FirebaseRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  UserType? currentUserType;

  UserType get userType {
    // If currentUserType is null, try to determine it from current user
    if (currentUserType == null) {
      final user = firebaseAuth.currentUser;
      if (user?.email == 'admin@admin.com') {
        currentUserType = UserType.admin;
      } else {
        currentUserType = UserType.user;
      }
    }
    return currentUserType ?? UserType.user;
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) return null;

    // Always set user type when getting current user
    await setUserTypeFromEmail();

    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
    );
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Set display name
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        displayName: name,
        photoUrl: null,
      );

      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);

      setUserTypeFromEmail();

      return user;
    } catch (e) {
      throw Exception('Login failed: \$e');
    }
  }

  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset email sent successfully check your inbox";
    } catch (e) {
      return "An error occured while sending password reset email: \$e";
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) throw Exception('No user is currently logged in');
      await user.delete();
      await logout();
    } catch (e) {
      throw Exception('Account deletion failed: \$e');
    }
  }

  @override
  Future<void> logout() async {
    currentUserType = null; // Clear user type on logout
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();
      await googleSignIn.signOut();
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;

      setUserTypeFromEmail();

      return AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
      );
    } catch (e) {
      throw Exception('Sign in with Google failed: \$e');
    }
  }

  Future<void> setUserTypeFromEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.email == 'admin@admin.com') {
        currentUserType = UserType.admin;
      } else {
        currentUserType = UserType.user;
      }
    }
  }

  /// Initialize user type on app startup
  Future<void> initializeUserType() async {
    await setUserTypeFromEmail();
  }
}
