import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> showExceptionAlertDialog(BuildContext context,
        {@required String title, @required Exception exception}) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message(exception)),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text("OK"))
              ],
            ));

String message(Exception exception) {
  if (exception is FirebaseException) return exception.message;
  return exception.toString();
}
