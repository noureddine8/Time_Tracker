import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/auth/email_sign_in_model.dart';
import 'package:flutter_app/services/auth.dart';

class EmailSignInBloc {
  final AuthBase auth;
  final StreamController<EmailSigninModel> _modelController =
      StreamController<EmailSigninModel>();

  EmailSignInBloc({@required this.auth});

  Stream<EmailSigninModel> get modelStream => _modelController.stream;
  EmailSigninModel _model = EmailSigninModel();

  void updateWith(
      {String email, String password, bool isLoading, bool isSignIn}) {
    _model = _model.copyWith(
        email: email,
        isLoading: isLoading,
        isSignIn: isSignIn,
        password: password);

    _modelController.add(_model);
  }

  Future<void> submit() async {
    updateWith(isLoading: true);
    try {
      if (_model.isSignIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.signUpWithEmailAndPassword(_model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void dispose() {
    _modelController.close();
  }
}
