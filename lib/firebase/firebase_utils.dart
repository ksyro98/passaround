import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:passaround/entities/pa_user.dart';
import 'package:passaround/entities/pa_user_manager.dart';

import '../firebase_options.dart';

class FirebaseUtils {
  static const String userItemsCollectionName = 'userItems';
  static const String sharedCollectionName = 'shared';
  static const String defaultId = 'default-id';

  static Future<void> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    _initializeUser();
  }

  static void _initializeUser() {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      PaUser user = PaUser(
        id: firebaseUser.uid,
        username: firebaseUser.displayName ?? "",
        email: firebaseUser.email ?? "",
      );
      PaUserManager.get().current = user;
    }
  }
}
