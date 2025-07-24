import 'package:local_auth/local_auth.dart';
import 'dart:io';

class LocalAuthService {
  static final LocalAuthentication _auth = LocalAuthentication();

  /// Checks if device supports biometrics (Face ID or fingerprint)
  static Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics && await _auth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  /// Authenticates the user using Face ID (iOS) or fingerprint (Android)
  static Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: Platform.isIOS
            ? 'Please authenticate with Face ID'
            : 'Please authenticate with your fingerprint',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return didAuthenticate;
    } catch (e) {
      return false;
    }
  }
}
