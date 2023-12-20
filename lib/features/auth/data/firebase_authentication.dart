import 'package:firebase_auth/firebase_auth.dart';
import 'package:passaround/features/auth/data/auth_firestore.dart';
import 'package:passaround/features/auth/data/auth_remote_data_provider.dart';
import 'package:passaround/utils/logger.dart';

import '../../../utils/functions.dart';

class FirebaseAuthentication implements AuthRemoteDataProvider {
  static const String _invalidLogInCredentials = "Invalid login credentials. Please try again.";
  static const String _weakPasswordOnSignUp = "The password needs to be at least 6 characters long.";
  static const String _accountAlreadyExistsOnSignUp = "An account already exists for that email.";
  static const String _passwordRecoveryError = "An error occurred while recovering your password. Please try again.";
  static const String _unknownError = "An unknown error occurred. Please try again later.";

  @override
  Future<Map<String, String>> logIn(String email, String password) async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return {
        "id": credential.user?.uid ?? "",
        "username": credential.user?.displayName ?? "",
        "email": email,
      };
    } on FirebaseAuthException catch (e) {
      return _getLogInError(e);
    } catch (e) {
      return _getUnknownError();
    }
  }

  @override
  Future<Map<String, String>> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      await Future.wait<void>([
        credential.user?.updateDisplayName(username) ?? doNothing(),
        AuthFirestore(credential.user?.uid).createUserDocument()
      ]);

      return {
        "id": credential.user?.uid ?? "",
        "username": username,
        "email": email,
      };
    } on FirebaseAuthException catch (e) {
      return _getSignUpError(e);
    } catch (e) {
      return _getUnknownError();
    }
  }

  @override
  Future<Map<String, dynamic>> recoverPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return {"succeeded": true};
    } catch (e) {
      Logger.ePrint(e);
      return _getPasswordRecoveryError();
    }
  }

  Map<String, String> _getLogInError(FirebaseAuthException e) {
    if (e.code == "invalid-login-credentials") {
      return {"error": _invalidLogInCredentials};
    } else {
      return _getUnknownError();
    }
  }

  Map<String, String> _getSignUpError(FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      return {"error": _weakPasswordOnSignUp};
    } else if (e.code == 'email-already-in-use') {
      return {"error": _accountAlreadyExistsOnSignUp};
    } else {
      return _getUnknownError();
    }
  }

  Map<String, String> _getPasswordRecoveryError() {
    return {"error": _passwordRecoveryError};
  }

  Map<String, String> _getUnknownError() {
    return {"error": _unknownError};
  }
}
