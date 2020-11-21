

import 'package:flutter_redux_boilerplate/core/models/user.dart';

class LoginRequest {
   final String username;
  final String password;

  LoginRequest(this.username, this.password);

}

class LoginSuccess {
    final User user;

    LoginSuccess(this.user);
}

class LoginFailure {
    final String error;

    LoginFailure(this.error);
}