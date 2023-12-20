import 'package:firebase_auth/firebase_auth.dart';
import 'package:passaround/data_structures/extended_bool.dart';
import 'package:passaround/features/profile/data/profile_datasource.dart';
import 'package:passaround/utils/logger.dart';

class FirebaseAuthenticationUserManager implements ProfileDatasource {
  static const String _errorInEmailUpdate = "An error occurred while updating your email. Please try again.";
  static const String _errorInUsernameUpdate = "An error occurred while updating your username. Please try again.";
  static const String _errorInPasswordUpdate = "An error occurred while updating your password. Please try again.";


  @override
  Future<ExtendedBool> updateEmail(String newEmail) async {
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(newEmail);
      return const ExtendedBool(true);
    }  catch(e) {
      Logger.ePrint(e);
      return const ExtendedBool(false, detail: _errorInEmailUpdate);
    }
  }

  @override
  Future<ExtendedBool> updatePassword(String newUsername) async {
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(newUsername);
      return const ExtendedBool(true);
    }  catch(e) {
      Logger.ePrint(e);
      return const ExtendedBool(false, detail: _errorInUsernameUpdate);
    }
  }

  @override
  Future<ExtendedBool> updateUsername(String newPassword) async {
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(newPassword);
      return const ExtendedBool(true);
    }  catch(e) {
      Logger.ePrint(e);
      return const ExtendedBool(false, detail: _errorInPasswordUpdate);
    }
  }

  @override
  Future<void> logOut() async => await FirebaseAuth.instance.signOut();
}
