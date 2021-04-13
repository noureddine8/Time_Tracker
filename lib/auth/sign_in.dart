import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Time tracker"),
          centerTitle: true,
          elevation: 5,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "SIGN IN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  flex: 2),
              Flexible(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RowContent(
                          color: Colors.red,
                          text: "Sign in with google",
                        ),
                        RowContent(
                          color: Colors.blue,
                          text: "Sign in with facebook",
                        )
                      ],
                    ),
                  ),
                  flex: 2)
            ],
          ),
        ));
  }
}

class RowContent extends StatelessWidget {
  const RowContent({
    this.color,
    this.text,
    Key key,
  }) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: ElevatedButton(
          onPressed: _signInWithGoogle,
          child: Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              primary: color,
              elevation: 3.0,
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              shadowColor: color)),
    );
  }

  void _signInWithGoogle() {
    // TODO : Auth With Google
  }
}
