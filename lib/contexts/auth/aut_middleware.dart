import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/login/login_action.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/services/firebase/FirebaseAuthentification.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';

@injectable
class AuthMiddleware {
  Auth auth;
  AuthMiddleware(this.auth);
  GlobalKey<NavigatorState> navigatorKey;

  login(Store<AppState> store, LoginRequest action, NextDispatcher next) async {
    this
        .auth
        .signInWithEmailAndPassword(action.username, action.password)
        .then((value) => store.dispatch(LoginSuccess(value)));

    next(action);
  }
}

List<Middleware<AppState>> createStoreAuthMiddleware(navigatorKey) {
  AuthMiddleware middleware = getIt<AuthMiddleware>();
  middleware.navigatorKey=navigatorKey;
  return [
    TypedMiddleware<AppState, LoginRequest>(middleware.login),
  ];
}
