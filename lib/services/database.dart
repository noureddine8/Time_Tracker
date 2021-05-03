import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/home/models/job.dart';
import 'package:flutter_app/services/APIPath.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  final String uid;
  static int id = 0;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final DocumentReference ref = FirebaseFirestore.instance.doc(path);
    await ref.set(data);
  }

  @override
  Stream<List<Job>> jobsStream() {
    final path = APIPath.jobs(uid);
    final ref = FirebaseFirestore.instance.collection(path);
    final snapshots = ref.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((e) {
          final data = e.data();
          return data != null
              ? Job(name: data["name"], ratePerHour: data["ratePerHour"])
              : null;
        }).toList());
  }

  @override
  Future<void> createJob(Job jobData) =>
      _setData(data: jobData.toMap(), path: APIPath.job(uid, "jobabc_5"));
}
