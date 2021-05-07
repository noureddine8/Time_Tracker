import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/home/models/job.dart';
import 'package:flutter_app/services/APIPath.dart';
import 'package:flutter_app/services/FirestoreService.dart';

abstract class Database {
  Future<void> setJob(Job job, bool isEdit);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  final String uid;
  static int id = 0;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final FirestoreService _service = FirestoreService.instance;

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
      path: APIPath.jobs(uid), builder: (data, id) => Job.fromMap(data, id));

  @override
  Future<void> setJob(Job jobData, bool isEdit) async {
    final jobs = await jobsStream().first;
    final allNames = jobs.map((e) => e.name).toList();
    if (isEdit) {
      allNames.remove(jobData.name);
    }
    if (allNames.contains(jobData.name)) {
      throw FirebaseException(
          message: "Job with this name already exists",
          plugin: "Name already in use");
    }
    return _service.setData(
        data: jobData.toMap(), path: APIPath.job(uid, jobData.id));
  }
}
