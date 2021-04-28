import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth/email_sign_in_bloc.dart';
import 'package:flutter_app/auth/email_sign_in_model.dart';
import 'package:flutter_app/auth/show_exception_alert_dialog.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';

class EmailSignInFormBlocBased extends StatefulWidget {
  const EmailSignInFormBlocBased({Key key, @required this.bloc})
      : super(key: key);

  final EmailSignInBloc bloc;
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<EmailSignInBloc>(
          builder: (_, bloc, __) => EmailSignInFormBlocBased(bloc: bloc)),
    );
  }

  @override
  _EmailSignInFormBlocBasedState createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  Future<void> _submit() async {
    try {
      await widget.bloc.submit();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(context, title: "Sign in failed", exception: e);
    }
  }

  void _toggleFormType(EmailSigninModel model) {
    widget.bloc.updateWith(isSignIn: !model.isSignIn);
    widget.bloc.updateWith(email: "");
    widget.bloc.updateWith(password: "");
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSigninModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSigninModel(),
        builder: (context, snapshot) {
          final EmailSigninModel model = snapshot.data;
          return Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(model),
            ),
          );
        });
  }

  List<Widget> _buildChildren(EmailSigninModel model) {
    final buttonText = model.isSignIn ? "SIGN IN" : "SIGN UP";
    final secondText = model.isSignIn
        ? "Need an account? Register"
        : "Already have an account? Sign in";
    final bool isButtonEnabled =
        !model.isloading && model.email.isNotEmpty && model.password.isNotEmpty;

    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
            labelText: "Email",
            hintText: "type your email",
            enabled: !model.isloading),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (email) {
          widget.bloc.updateWith(email: email);
        },
      ),
      TextField(
        controller: _passwordController,
        obscureText: true,
        decoration:
            InputDecoration(labelText: "Password", enabled: !model.isloading),
        textInputAction: TextInputAction.done,
        onChanged: (password) {
          widget.bloc.updateWith(password: password);
        },
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
            onPressed: model.isloading ? null : () => _toggleFormType(model),
            style:
                OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
          ))
    ];
  }
}
