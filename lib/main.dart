import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/auth/sign_in.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.cyan));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Time Tracker",
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("An error has occured")],
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return SignInPage();
            }
            return CircularProgressIndicator();
          },
        ));
  }
}
