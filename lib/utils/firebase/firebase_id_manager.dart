import 'package:passaround/entities/pa_user_manager.dart';
import 'package:passaround/utils/firebase/firebase_utils.dart';

class FirebaseIdManager {
  static FirebaseIdManager? _instance;

  String? _id;
  String get id => (_id ?? PaUserManager.get().current?.id) ?? FirebaseUtils.defaultId;
  set id(String newId) => _id = newId;

  factory FirebaseIdManager.get([String? id]) {
    return _instance ??= FirebaseIdManager._(id);
  }

  FirebaseIdManager._(this._id);

  void unsetId() => _id = null;
}
