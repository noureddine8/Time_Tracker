import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/services/auth.dart';

import 'auth/sign_in.dart';

class Landing extends StatefulWidget {
  const Landing({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  User _user;

  @override
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser);
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return MaterialApp(
        title: "Time Tracker",
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: SignInPage(
          auth: Auth(),
          onSignIn: _updateUser,
        ),
        debugShowCheckedModeBanner: false,
      );
    } else {
      return MaterialApp(
        title: "Time Tracker",
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: Home(
          auth: Auth(),
          onSignOut: () => _updateUser(null),
        ),
        debugShowCheckedModeBanner: false,
      );
    }
  }
}
