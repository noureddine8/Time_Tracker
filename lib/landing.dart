import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/services/auth.dart';

import 'auth/sign_in.dart';

class Landing extends StatelessWidget {
  const Landing({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          if (user == null) {
            return MaterialApp(
              title: "Time Tracker",
              theme: ThemeData(
                primarySwatch: Colors.brown,
              ),
              home: SignInPage(
                auth: auth,
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
                auth: auth,
              ),
              debugShowCheckedModeBanner: false,
            );
          }
        }
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
