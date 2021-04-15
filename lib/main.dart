import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/landing.dart';
import 'package:flutter_app/services/auth.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.brown));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
              title: Text("Flutter-App Error"),
            )),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Landing(
            auth: Auth(),
          );
        }
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text("Flutter-App Loading"),
              backgroundColor: Colors.brown,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()],
            ),
          ),
        );
      },
    );
  }
}
