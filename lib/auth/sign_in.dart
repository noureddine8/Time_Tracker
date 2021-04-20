import 'package:flutter/material.dart';
import 'package:flutter_app/auth/authButton.dart';
import 'package:flutter_app/auth/email_sign_in_page.dart';
import 'package:flutter_app/services/auth.dart';

import 'customButton.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _anonymousSignIn() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _googleSignIn() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _facebookSignIn() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  void onSigninClick(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmailSigninPage(), fullscreenDialog: true));
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
                onPress: () => onSigninClick(context),
              ),
              SizedBox(height: 50),
              AuthButton(
                color: Colors.grey[200],
                image: "images/google-logo.png",
                text: "Sign in with google",
                textColor: Colors.black,
                borderColor: Color(0XFFDB4437),
                onPress: _googleSignIn,
              ),
              AuthButton(
                color: Color(0xff3b5998),
                image: "images/facebook-logo.png",
                text: "Sign in with facebook",
                textColor: Colors.white,
                borderColor: Color(0xff3b5998),
                onPress: _facebookSignIn,
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
