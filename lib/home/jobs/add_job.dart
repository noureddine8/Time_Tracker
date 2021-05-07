import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth/show_exception_alert_dialog.dart';
import 'package:flutter_app/home/models/job.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';

class AddJob extends StatefulWidget {
  final Database database;

  const AddJob({Key key, @required this.database}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    final Database database = Provider.of<Database>(context, listen: false);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => AddJob(
                  database: database,
                ),
            fullscreenDialog: true));
  }

  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  final _formKey = GlobalKey<FormState>();

  String _jobName;
  int _ratePerHour;

  bool _validateAndSaveForm() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final Job job = Job(name: _jobName, ratePerHour: _ratePerHour);
        await widget.database.createJob(job);
        Navigator.pop(context);
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(context,
            title: "Operation Failed", exception: e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: Text("Add new job"),
        actions: [
          ElevatedButton(
            onPressed: _submit,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(elevation: 50),
          )
        ],
      ),
      body: buildBuildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget buildBuildContents() {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
              elevation: 3.0,
              child:
                  Padding(padding: EdgeInsets.all(10.0), child: _buildForm()))),
    );
  }

  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildFormChildren(),
        ));
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: "Job Name"),
        onSaved: (value) => _jobName = value,
        validator: (value) => value.isEmpty ? "Name can't be empty" : null,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: "Rate Per Hour"),
        keyboardType:
            TextInputType.numberWithOptions(decimal: false, signed: false),
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
      )
    ];
  }
}
