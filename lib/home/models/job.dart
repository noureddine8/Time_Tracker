import 'package:flutter/foundation.dart';

class Job {
  final String id;
  final String name;
  final int ratePerHour;

  Job({@required this.id, @required this.name, @required this.ratePerHour});

  factory Job.fromMap(Map<String, dynamic> data, String id) {
    if (data == null) {
      return null;
    }
    final String name = data["name"];
    final int ratePerHour = data["ratePerHour"];
    return Job(id: id, name: name, ratePerHour: ratePerHour);
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "ratePerHour": ratePerHour};
  }
}
