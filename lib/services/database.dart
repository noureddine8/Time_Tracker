import 'package:flutter/foundation.dart';
import 'package:flutter_app/home/models/job.dart';
import 'package:flutter_app/services/APIPath.dart';
import 'package:flutter_app/services/FirestoreService.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  final String uid;
  static int id = 0;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final FirestoreService _service = FirestoreService.instance;

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
      path: APIPath.jobs(uid), builder: (data) => Job.fromMap(data));

  @override
  Future<void> createJob(Job jobData) => _service.setData(
      data: jobData.toMap(), path: APIPath.job(uid, "jobabc_5"));
}
