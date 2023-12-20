import 'package:passaround/data_structures/either.dart';
import 'package:passaround/data_structures/extended_bool.dart';
import 'package:passaround/entities/pa_user.dart';
import 'package:passaround/features/auth/bloc/auth_data_access.dart';

import '../dummy_pa_user.dart';

class MockAuthDataAccess implements AuthDataAccess {
  final bool shouldSucceed;

  MockAuthDataAccess({required this.shouldSucceed});

  @override
  Future<Either<String, PaUser>> logIn(String email, String password) async {
    return shouldSucceed ? Either.secondOnly(DummyPaUser.getWithEmail(email)) : const Either.firstOnly("login error");
  }

  @override
  Future<Either<String, PaUser>> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    return shouldSucceed ? Either.secondOnly(DummyPaUser.getWithEmail(email)) : const Either.firstOnly("signup error");
  }

  @override
  Future<ExtendedBool> recoverPassword(String email) async {
    return shouldSucceed ? const ExtendedBool(true) : const ExtendedBool(false, detail: "recovery error");
  }
}
