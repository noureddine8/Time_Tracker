import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth/authButton.dart';
import 'package:flutter_app/services/auth.dart';

import 'customButton.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.onSignIn, @required this.auth})
      : super(key: key);
  final void Function(User) onSignIn;
  final AuthBase auth;

  Future<void> _anonymousSignIn() async {
    try {
      final user = await auth.signInAnonymously();
      onSignIn(user);
    } catch (e) {
      print(e.toString());
    }
  }

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
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 250, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                color: Colors.brown,
                text: "Sign in ",
                onPress: () {},
              ),
              SizedBox(height: 50),
              AuthButton(
                color: Colors.grey[200],
                image: "images/google-logo.png",
                text: "Sign in with google",
                textColor: Colors.black,
                borderColor: Color(0XFFDB4437),
              ),
              AuthButton(
                color: Color(0xff3b5998),
                image: "images/facebook-logo.png",
                text: "Sign in with facebook",
                textColor: Colors.white,
                borderColor: Color(0xff3b5998),
              ),
              Text(
                "Or",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              CustomButton(
                color: Colors.grey,
                text: "Go anonymous",
                onPress: _anonymousSignIn,
              )
            ],
          ),
        ));
  }
}
