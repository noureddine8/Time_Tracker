import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/home/models/job.dart';
import 'package:flutter_app/services/APIPath.dart';
import 'package:flutter_app/services/FirestoreService.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

String documentId() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  final String uid;
  static int id = 0;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final FirestoreService _service = FirestoreService.instance;

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
      path: APIPath.jobs(uid), builder: (data) => Job.fromMap(data));

  @override
  Future<void> createJob(Job jobData) async {
    final jobs = await jobsStream().first;
    final allNames = jobs.map((e) => e.name).toList();
    if (allNames.contains(jobData.name)) {
      throw FirebaseException(message:"Job with this name already exists",plugin: "Name already in use");
    }
    return _service.setData(
        data: jobData.toMap(), path: APIPath.job(uid, documentId()));
  }
}
