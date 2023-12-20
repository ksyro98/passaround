import 'package:passaround/entities/pa_user.dart';
import 'package:passaround/features/auth/bloc/auth_data_access.dart';

import '../../../data_structures/either.dart';
import '../../../data_structures/extended_bool.dart';
import 'auth_remote_data_provider.dart';

class AuthRepository implements AuthDataAccess {
  final AuthRemoteDataProvider _dataProvider;

  const AuthRepository(this._dataProvider);

  @override
  Future<Either<String, PaUser>> logIn(String email, String password) async => await _manageAuthentication(
        email: email,
        password: password,
        authenticationMethod: _dataProvider.logIn,
      );

  @override
  Future<Either<String, PaUser>> signUp({
    required String username,
    required String email,
    required String password,
  }) async =>
      await _manageAuthentication(
        email: email,
        password: password,
        authenticationMethod: (managedEmail, managedPassword) => _dataProvider.signUp(
          username: username,
          email: managedEmail,
          password: managedPassword,
        ),
      );

  Future<Either<String, PaUser>> _manageAuthentication({
    required String email,
    required String password,
    required Future<Map<String, String>> Function(String, String) authenticationMethod,
  }) async {
    final Map<String, String> res = await authenticationMethod(email, password);
    final bool succeeded = !res.containsKey("error");

    return succeeded ? Either.secondOnly(PaUser.fromMap(res)) : Either.firstOnly(res["error"]);
  }

  @override
  Future<ExtendedBool> recoverPassword(String email) async {
    final Map<String, dynamic> res = await _dataProvider.recoverPassword(email);
    return res.containsKey("succeeded") ? const ExtendedBool(true) : ExtendedBool(false, detail: res["error"]);
  }
}
