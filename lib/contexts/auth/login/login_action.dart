import 'package:flutter_redux_boilerplate/models/user.dart';

class LoginRequest {
  LoginRequest(){
    print('you run the action UserLoginRequest ');
  }
}

class LoginSuccess {
    final User user;

    LoginSuccess(this.user);
}

class LoginFailure {
    final String error;

    LoginFailure(this.error);
}