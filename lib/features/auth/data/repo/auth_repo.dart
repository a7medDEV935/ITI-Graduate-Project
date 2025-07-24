import '../models/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> getCurrentUser();
  Future<AppUser?> registerWithEmailPassword(String name , String email, String password);
  Future<AppUser?> loginWithEmailPassword(String email , String password);
  Future<String> sendPasswordResetEmail(String email);
  Future<void> deleteAccount();
  Future<void> logout();
  Future<AppUser?> signInWithGoogle();
}
