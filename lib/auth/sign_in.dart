import 'package:flutter/material.dart';
import 'package:flutter_app/auth/authButton.dart';
import 'package:flutter_app/auth/email_sign_in_page.dart';
import 'package:flutter_app/auth/show_exception_alert_dialog.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';

import 'customButton.dart';

class SignInPage extends StatelessWidget {
  Future<void> _anonymousSignIn(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    } catch (e) {
      showExceptionAlertDialog(context, title: "Signin failded", exception: e);
    }
  }

  Future<void> _googleSignIn(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } catch (e) {
      showExceptionAlertDialog(context, title: "Signin failded", exception: e);
    }
  }

  Future<void> _facebookSignIn(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithFacebook();
    } catch (e) {
      showExceptionAlertDialog(context, title: "Signin failded", exception: e);
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
                onPress: () => _googleSignIn(context),
              ),
              AuthButton(
                color: Color(0xff3b5998),
                image: "images/facebook-logo.png",
                text: "Sign in with facebook",
                textColor: Colors.white,
                borderColor: Color(0xff3b5998),
                onPress: () => _facebookSignIn(context),
              ),
              Text(
                "Or",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              CustomButton(
                color: Colors.grey,
                text: "Go anonymous",
                onPress: () => _anonymousSignIn(context),
              )
            ],
          ),
        ));
  }
}
