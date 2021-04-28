import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth/show_exception_alert_dialog.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';

class EmailSigninForm extends StatefulWidget {
  @override
  _EmailSigninFormState createState() => _EmailSigninFormState();
}

class _EmailSigninFormState extends State<EmailSigninForm> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _isSignIn = true;
  bool _isloading = false;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  Future<void> _submit() async {
    setState(() {
      _isloading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_isSignIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.signUpWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(context, title: "Sign in failed", exception: e);
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  void _toggleFormType() {
    setState(() {
      _isSignIn = !_isSignIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    final buttonText = _isSignIn ? "SIGN IN" : "SIGN UP";
    final secondText = _isSignIn
        ? "Need an account? Register"
        : "Already have an account? Sign in";
    final bool isButtonEnabled =
        !_isloading && _email.isNotEmpty && _password.isNotEmpty;

    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
            labelText: "Email",
            hintText: "type your email",
            enabled: !_isloading),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (e) {
          setState(() {});
        },
      ),
      TextField(
        controller: _passwordController,
        obscureText: true,
        decoration:
            InputDecoration(labelText: "Password", enabled: !_isloading),
        textInputAction: TextInputAction.done,
        onChanged: (e) {
          setState(() {});
        },
      ),
      Container(
          margin: EdgeInsets.only(top: 10.0),
          child: ElevatedButton(
              child: Text(buttonText),
              onPressed: isButtonEnabled ? _submit : null)),
      Container(
          margin: EdgeInsets.only(top: 10.0),
          child: OutlinedButton(
            child: Text(secondText),
            onPressed: _isloading ? null : _toggleFormType,
            style:
                OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
          ))
    ];
  }
}
