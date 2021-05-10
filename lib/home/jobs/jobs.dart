import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth/show_exception_alert_dialog.dart';
import 'package:flutter_app/home/jobs/add_job.dart';
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

  Future<void> _delete(BuildContext context, Job job) async {
    final database = Provider.of<Database>(context, listen: false);
    try {
      await database.deleteJob(job);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: "Operation failed", exception: e);
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
          child: Icon(Icons.add), onPressed: () => AddJob.show(context)),
    );
  }

  Widget _buildContents(BuildContext context) {
    final Database database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
        stream: database.jobsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final jobs = snapshot.data;

            return jobs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No jobs yet",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Add a new job by clicking the button below"),
                      ],
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                    ),
                    itemCount: jobs.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0 || index == jobs.length + 1)
                        return Container();
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => _delete(context, jobs[index - 1]),
                        key: UniqueKey(),
                        child: ListTile(
                          onTap: () =>
                              AddJob.show(context, jobToEdit: jobs[index - 1]),
                          trailing: Icon(Icons.chevron_right),
                          leading: Icon(Icons.work),
                          title: Text(jobs[index - 1].name),
                          subtitle:
                              Text(jobs[index - 1].ratePerHour.toString()),
                        ),
                      );
                    },
                  );
          } else if (snapshot.hasError) {
            return Center(child: Text("An error occured"));
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
