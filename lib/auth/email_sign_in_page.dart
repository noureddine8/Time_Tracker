import 'package:flutter/material.dart';
import 'package:flutter_app/auth/email_signin_form.dart';
import 'package:flutter_app/services/auth.dart';

class EmailSigninPage extends StatelessWidget {
  const EmailSigninPage({Key key, this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Time tracker",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            child: EmailSigninForm(
              auth: auth,
            ),
          ),
        ),
      ),
    );
  }
}
