import 'package:flutter/material.dart';
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
            final children = jobs
                .map(
                  (job) => ListTile(
                    onTap: () => AddJob.show(context, jobToEdit: job),
                    trailing: Icon(Icons.chevron_right),
                    leading: Icon(Icons.work),
                    title: Text(job.name),
                    subtitle: Text(job.ratePerHour.toString()),
                  ),
                )
                .toList();
            return children.length == 0
                ? Center(
                    child: Text(
                      "No jobs yet",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView(children: children);
          } else if (snapshot.hasError) {
            return Center(child: Text("An error occured"));
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
