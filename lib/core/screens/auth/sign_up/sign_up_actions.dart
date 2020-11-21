class UserSignUpRequest {
  final String username;
  final String password;

  UserSignUpRequest(this.username, this.password);
}

class SignUpSuccess {
  final String username;
  final String password;

  SignUpSuccess(this.username, this.password);
}
