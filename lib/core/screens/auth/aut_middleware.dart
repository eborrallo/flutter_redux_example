import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/config/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/config/screens.dart';
import 'package:flutter_redux_boilerplate/core/models/user.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/auth_actions.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/login/login_action.dart';
import 'package:flutter_redux_boilerplate/core/services/Auth.dart';
import 'package:flutter_redux_boilerplate/core/services/navigation/navigation_actions.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:injectable/injectable.dart';
import 'package:page_transition/page_transition.dart';
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
        .then((value) {
      store.dispatch(LoginSuccess(value));
      store.dispatch(NavigateToNextAndReplace(destination: MAIN_SCREEN,pageTransition:PageTransitionType.fade));
    });
    next(action);
  }

  isLoged(Store<AppState> store, IsAuthenticifated action,
      NextDispatcher next) async {
    try {
      User user = await this.auth.getSignedInUser();
      store.dispatch(NavigateToNextAndReplace(destination: MAIN_SCREEN,pageTransition:PageTransitionType.fade ));
    } catch (e) {
      //print(e);
      store.dispatch(NavigateToNextAndReplace(destination: LOGIN_SCREEN));
    }
    next(action);
  }

  logout(Store<AppState> store, UserLogout action, NextDispatcher next) async {
    store.dispatch(NavigateToNextAndReplace(destination: LOGIN_SCREEN));

    next(action);
  }
}

List<Middleware<AppState>> createStoreAuthMiddleware(navigatorKey) {
  AuthMiddleware middleware = getIt<AuthMiddleware>();
  middleware.navigatorKey = navigatorKey;
  return [
    TypedMiddleware<AppState, LoginRequest>(middleware.login),
    TypedMiddleware<AppState, UserLogout>(middleware.logout),
    TypedMiddleware<AppState, IsAuthenticifated>(middleware.isLoged),
  ];
}
