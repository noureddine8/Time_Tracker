import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';

import 'auth/sign_in.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          if (user == null) {
            return SignedIn();
          } else {
            return HomePage();
          }
        }
        return Loading();
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Time Tracker",
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class SignedIn extends StatelessWidget {
  const SignedIn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Time Tracker",
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: SignInPage.create(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
