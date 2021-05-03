import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth/show_exception_alert_dialog.dart';
import 'package:flutter_app/home/models/job.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';

class Jobs extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              title: Text("SIGN OUT"),
              content: Text("Are yo sure you want to sign out?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text("NO")),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("YES"))
              ],
            ));
    if (didRequestSignOut) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs Page"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () => _confirmSignOut(context),
              child: Text(
                "Log out",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => _createJob(context)),
    );
  }

  Future<void> _createJob(BuildContext context) async {
    final Database database = Provider.of<Database>(context, listen: false);
    try {
      await database.createJob(Job(name: "Gaming", ratePerHour: 8));
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: "Operation failed", exception: e);
    }
  }

  Widget _buildContents(BuildContext context) {
    final Database database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
        stream: database.jobsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final jobs = snapshot.data;
            final children = jobs.map((job) => Text(job.name)).toList();
            return ListView(children: children);
          } else if (snapshot.hasError) {
            return Center(child: Text("An error occured"));
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
