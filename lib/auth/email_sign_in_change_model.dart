import 'package:flutter/foundation.dart';
import 'package:flutter_app/services/auth.dart';

class EmailSigninChangeModel with ChangeNotifier {
  String password;
  String email;
  bool isSignIn;
  bool isloading;
  final AuthBase auth;

  EmailSigninChangeModel(
      {this.password = "",
      this.email = "",
      this.isSignIn = true,
      this.isloading = false,
      @required this.auth});

  String get buttonText {
    return isSignIn ? "SIGN IN" : "SIGN UP";
  }

  String get secondText {
    return isSignIn
        ? "Need an account? Register"
        : "Already have an account? Sign in";
  }

  bool get isButtonEnabled {
    return !isloading && email.isNotEmpty && password.isNotEmpty;
  }

  void updateWith(
      {String email, String password, bool isLoading, bool isSignIn}) {
    this.email = email ?? this.email;
    this.isSignIn = isSignIn ?? this.isSignIn;
    this.isloading = isLoading ?? this.isloading;
    this.password = password ?? this.password;
    notifyListeners();
  }

  Future<void> submit() async {
    updateWith(isLoading: true);
    try {
      if (isSignIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        await auth.signUpWithEmailAndPassword(email, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }
}
