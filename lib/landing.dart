import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/services/auth_provider.dart';

import 'auth/sign_in.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.of(context);
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
              home: SignInPage(),
              debugShowCheckedModeBanner: false,
            );
          } else {
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
