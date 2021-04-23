import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_provider.dart';

class Home extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    final auth = AuthProvider.of(context);
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              title: Text("SIGN OUT"),
              content: Text("Are yo sure you want to sign out?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text("NO")),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("YES"))
              ],
            ));
    if (didRequestSignOut) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () => _confirmSignOut(context),
              child: Text(
                "Log out",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
