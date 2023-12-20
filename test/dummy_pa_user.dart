import 'package:passaround/entities/pa_user.dart';

class DummyPaUser {
  static PaUser get() => const PaUser(id: "dummyId", username: "dummyUsername", email: "dummyEmail");

  static PaUser getWithEmail(String email) => PaUser(id: "dummyId", username: "dummyUsername", email: email);

  static PaUser getWithId(String id) => PaUser(id: id, username: "dummyUsername", email: "dummyEmail");
}
