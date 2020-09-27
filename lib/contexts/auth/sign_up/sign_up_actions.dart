import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_boilerplate/models/user.dart';

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
