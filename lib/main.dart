import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/auth/sign_in.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.blue));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Time Tracker",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
