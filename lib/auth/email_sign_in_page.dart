import 'package:flutter/material.dart';
import 'package:flutter_app/auth/email_sign_in_form_bloc_based.dart';

class EmailSigninPage extends StatelessWidget {
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
            child: EmailSignInFormBlocBased.create(context),
          ),
        ),
      ),
    );
  }
}
