import 'package:flutter/material.dart';

class EmailSigninForm extends StatefulWidget {
  @override
  _EmailSigninFormState createState() => _EmailSigninFormState();
}

class _EmailSigninFormState extends State<EmailSigninForm> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  void _submit() {
    print(
        "Email : ${_emailController.text} and Password : ${_passwordController.text}");
  }

  var _isSignIn = true;

  void _toggleFormType() {
    setState(() {
      _isSignIn = !_isSignIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "type your email",
        ),
      ),
      TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: 10.0),
          child: ElevatedButton(child: Text(buttonText), onPressed: _submit)),
      Container(
          margin: EdgeInsets.only(top: 10.0),
          child: OutlinedButton(
            child: Text(secondText),
            onPressed: _toggleFormType,
            style:
                OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
          ))
    ];
  }
}
