abstract class AuthRemoteDataProvider {
  Future<Map<String, String>> logIn(String email, String password);

  Future<Map<String, String>> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> recoverPassword(String email);
}
