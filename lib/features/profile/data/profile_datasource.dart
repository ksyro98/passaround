import 'package:passaround/data_structures/extended_bool.dart';

abstract class ProfileDatasource {
  Future<void> logOut();

  Future<ExtendedBool> updateUsername(String newUsername);

  Future<ExtendedBool> updateEmail(String newEmail);

  Future<ExtendedBool> updatePassword(String newPassword);
}

