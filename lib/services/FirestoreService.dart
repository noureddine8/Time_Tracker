import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  Future<void> setData({String path, Map<String, dynamic> data}) async {
    final DocumentReference ref = FirebaseFirestore.instance.doc(path);
    await ref.set(data);
  }

  Stream<List<T>> collectionStream<T>(
      {@required String path,
      @required T Function(Map<String, dynamic> data) builder}) {
    final ref = FirebaseFirestore.instance.collection(path);
    final snapshots = ref.snapshots();
    return snapshots.map(
        (snapshot) => snapshot.docs.map((e) => builder(e.data())).toList());
  }
}
