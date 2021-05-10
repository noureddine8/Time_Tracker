import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData(
      {@required String path, @required Map<String, dynamic> data}) async {
    final DocumentReference ref = FirebaseFirestore.instance.doc(path);
    await ref.set(data);
  }

  Future<void> deleteData({@required String path}) async {
    final DocumentReference ref = FirebaseFirestore.instance.doc(path);
    await ref.delete();
  }

  Stream<List<T>> collectionStream<T>(
      {@required
          String path,
      @required
          T Function(Map<String, dynamic> data, String documentId) builder}) {
    final ref = FirebaseFirestore.instance.collection(path);
    final snapshots = ref.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.map((e) => builder(e.data(), e.id)).toList());
  }
}
