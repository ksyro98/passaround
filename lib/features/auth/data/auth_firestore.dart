import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passaround/utils/firebase_utils.dart';

class AuthFirestore {
  final String userId;

  const AuthFirestore(String? userId) : userId = userId ?? FirebaseUtils.defaultDocumentId;

  Future<void> createUserDocument() async {
    Map<String, bool> data = { "created": true };
    FirebaseFirestore.instance.collection(FirebaseUtils.userItemsCollectionName).doc(userId).set(data);
  }
}