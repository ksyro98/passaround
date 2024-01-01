import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passaround/utils/firebase/firebase_id_manager.dart';

import '../../../../utils/firebase/firebase_utils.dart';
import '../../../../utils/logger.dart';

class ShareFirestore {
  CollectionReference<Map<String, dynamic>> get _sharedCollection {
    String documentId = FirebaseIdManager.get().id;
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.userItemsCollectionName)
        .doc(documentId)
        .collection(FirebaseUtils.sharedCollectionName);
  }

  Query<Map<String, dynamic>> get _queriedSharedCollection =>
      _sharedCollection.orderBy('ts', descending: true).limit(50);

  Future<List<Map<String, dynamic>>?> getItems() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _queriedSharedCollection.get();

      return querySnapshot.docs.map(_getItemData).toList();
    } catch (e) {
      Logger.ePrint(e);
      return null;
    }
  }

  Stream<List<Map<String, dynamic>>> newItemsStream() =>
      _queriedSharedCollection.snapshots().map((snapshot) => snapshot.docs.map(_getItemData).toList());

  Map<String, dynamic> _getItemData(QueryDocumentSnapshot<Map<String, dynamic>> firestoreDoc) {
    final Map<String, dynamic> data = firestoreDoc.data();
    data['id'] = firestoreDoc.id;
    return data;
  }

  Future<bool> writeOnSharedCollection(Map<String, dynamic> data) async {
    try {
      await _sharedCollection.add(data);
      return true;
    } catch (e) {
      Logger.ePrint(e);
      return false;
    }
  }

  Future<bool> deleteItem(String id) async {
    try {
      await _sharedCollection.doc(id).delete();
      return true;
    } catch (e) {
      Logger.ePrint(e);
      return false;
    }
  }
}