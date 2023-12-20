import 'package:equatable/equatable.dart';

class PaUser extends Equatable {
  static PaUser? _instance;

  static PaUser? get instance => _instance;

  static set(PaUser user) => _instance = user;

  static unset() => _instance = null;

  static PaUser fromMap(Map<String, String> map) {
    return PaUser(
      id: map["id"] ?? "",
      username: map["username"] ?? "",
      email: map["email"] ?? "",
    );
  }

  final String id;
  final String username;
  final String email;

  const PaUser({required this.id, required this.username, required this.email});

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
