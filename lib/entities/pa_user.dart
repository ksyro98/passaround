import 'package:equatable/equatable.dart';

class PaUser extends Equatable {
  final String id;
  final String username;
  final String email;

  const PaUser({required this.id, required this.username, required this.email});

  PaUser.fromMap(Map<String, String> map)
      : id = map["id"] ?? "",
        username = map["username"] ?? "",
        email = map["email"] ?? "";

  const PaUser.empty()
      : id = "",
        username = "",
        email = "";

  PaUser copyWith({String? id, String? username, String? email}) {
    return PaUser(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  PaUser copyWithMap(Map<String, String> map) {
    return copyWith(id: map["id"], username: map["username"], email: map["email"]);
  }

  @override
  List<Object?> get props => [id, username, email];
}
