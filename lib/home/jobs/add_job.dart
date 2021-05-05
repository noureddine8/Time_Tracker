import 'package:flutter/material.dart';

class AddJob extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (_) => AddJob(), fullscreenDialog: true));
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

  void _submit() {
    if (_validateAndSaveForm()) {
      print("saved, name : $_jobName and rate : $_ratePerHour");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: Text("Add new job"),
        actions: [
          TextButton(
              onPressed: _submit,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ))
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
