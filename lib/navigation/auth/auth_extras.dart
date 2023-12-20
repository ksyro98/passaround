class AuthExtras {
  final String? username;
  final String email;
  final String password;

  const AuthExtras({this.username, required this.email, required this.password});

  @override
  String toString() => "AuthExtras(username: $username, email: $email, password: $password)";
}