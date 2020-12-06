import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/Auth.dart';
import 'package:flutter_redux_boilerplate/domain/user/user.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserService {
  final Auth authService;

  UserService({Auth authService}) : authService = authService;
}
