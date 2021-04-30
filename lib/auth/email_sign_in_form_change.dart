import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth/email_sign_in_change_model.dart';
import 'package:flutter_app/auth/show_exception_alert_dialog.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';

class EmailSignInFormChange extends StatefulWidget {
  const EmailSignInFormChange({Key key, @required this.model})
      : super(key: key);

  final EmailSigninChangeModel model;
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSigninChangeModel>(
      create: (_) => EmailSigninChangeModel(auth: auth),
      child: Consumer<EmailSigninChangeModel>(
          builder: (_, model, __) => EmailSignInFormChange(
                model: model,
              )),
    );
  }

  @override
  _EmailSignInFormChangeState createState() => _EmailSignInFormChangeState();
}

class _EmailSignInFormChangeState extends State<EmailSignInFormChange> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  EmailSigninChangeModel get model => widget.model;

  Future<void> _submit() async {
    try {
      await model.submit();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(context, title: "Sign in failed", exception: e);
    }
  }

  void _toggleFormType() {
    model.updateWith(isSignIn: !model.isSignIn);
    model.updateWith(email: "");
    model.updateWith(password: "");
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    final buttonText = model.buttonText;
    final secondText = model.secondText;
    final bool isButtonEnabled = model.isButtonEnabled;

    return [
      TextField(
          controller: _emailController,
          decoration: InputDecoration(
              labelText: "Email",
              hintText: "type your email",
              enabled: !model.isloading),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (email) => model.updateWith(email: email)),
      TextField(
        controller: _passwordController,
        obscureText: true,
        decoration:
            InputDecoration(labelText: "Password", enabled: !model.isloading),
        textInputAction: TextInputAction.done,
        onChanged: (password) => model.updateWith(password: password),
      ),
      Container(
          margin: EdgeInsets.only(top: 10.0),
          child: ElevatedButton(
              child: Text(buttonText),
              onPressed: isButtonEnabled ? _submit : null)),
      Container(
          margin: EdgeInsets.only(top: 10.0),
          child: OutlinedButton(
            child: Text(secondText),
            onPressed: model.isloading ? null : () => _toggleFormType(),
            style:
                OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
          ))
    ];
  }
}
