import 'pa_user.dart';

class PaUserManager {
  static final PaUserManager _instance = PaUserManager._();

  PaUser? current;

  PaUserManager._();

  factory PaUserManager.get() => _instance;

  bool isLoggedIn() => current != null;
}
