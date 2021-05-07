import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth/show_exception_alert_dialog.dart';
import 'package:flutter_app/home/models/job.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';

class AddJob extends StatefulWidget {
  final Database database;
  final Job jobToEdit;

  const AddJob({Key key, @required this.database, this.jobToEdit})
      : super(key: key);
  static Future<void> show(BuildContext context, {Job jobToEdit}) async {
    final Database database = Provider.of<Database>(context, listen: false);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => AddJob(
                  jobToEdit: jobToEdit,
                  database: database,
                ),
            fullscreenDialog: true));
  }

  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.jobToEdit != null) {
      _jobName = widget.jobToEdit.name;
      _ratePerHour = widget.jobToEdit.ratePerHour;
    }
  }

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
        final bool isEdit = widget.jobToEdit == null ? false : true;
        final id = widget.jobToEdit?.id ?? DateTime.now().toIso8601String();
        final Job job = Job(id: id, name: _jobName, ratePerHour: _ratePerHour);
        await widget.database.setJob(job, isEdit);
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
        title: Text(widget.jobToEdit == null ? "Add new job" : "Edit job"),
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
        initialValue: _jobName,
        decoration: InputDecoration(labelText: "Job Name"),
        onSaved: (value) => _jobName = value,
        validator: (value) => value.isEmpty ? "Name can't be empty" : null,
      ),
      TextFormField(
        initialValue: _ratePerHour != null ? _ratePerHour.toString() : null,
        decoration: InputDecoration(labelText: "Rate Per Hour"),
        keyboardType:
            TextInputType.numberWithOptions(decimal: false, signed: false),
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
      )
    ];
  }
}
