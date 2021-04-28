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

  EmailSigninModel copyWith(
      {String email, String password, bool isLoading, bool isSignIn}) {
    return EmailSigninModel(
        email: email ?? this.email,
        isSignIn: isSignIn ?? this.isSignIn,
        isloading: isLoading ?? this.isloading,
        password: password ?? this.password);
  }
}
