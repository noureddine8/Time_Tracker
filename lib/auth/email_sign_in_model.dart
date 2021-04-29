class EmailSigninModel {
  final String password;
  final String email;
  final bool isSignIn;
  final bool isloading;

  EmailSigninModel(
      {this.password = "",
      this.email = "",
      this.isSignIn = true,
      this.isloading = false});

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

  EmailSigninModel copyWith(
      {String email, String password, bool isLoading, bool isSignIn}) {
    return EmailSigninModel(
        email: email ?? this.email,
        isSignIn: isSignIn ?? this.isSignIn,
        isloading: isLoading ?? this.isloading,
        password: password ?? this.password);
  }
}
