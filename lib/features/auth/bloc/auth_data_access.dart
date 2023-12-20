import 'package:passaround/data_structures/extended_bool.dart';

import '../../../data_structures/either.dart';
import '../../../entities/pa_user.dart';

abstract class AuthDataAccess {
  Future<Either<String, PaUser>> logIn(String email, String password);

  Future<Either<String, PaUser>> signUp({required String username, required String email, required String password});

  Future<ExtendedBool> recoverPassword(String email);
}