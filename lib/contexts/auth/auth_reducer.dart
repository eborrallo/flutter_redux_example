import 'package:flutter_redux_boilerplate/contexts/auth/auth_actions.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/auth_state.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/login/login_action.dart';
import 'package:redux/redux.dart';

Reducer<AuthState> authReducer = combineReducers([
  new TypedReducer<AuthState, LoginSuccess>(userAuthSuccessReducer),
  new TypedReducer<AuthState, LoginFailure>(userAuthFailureReducer),
  new TypedReducer<AuthState, UserLogout>(userLogoutReducer),
]);

AuthState userAuthSuccessReducer(AuthState auth, LoginSuccess action) {
  return auth.copyWith(
      isAuthenticated: true, isAuthenticating: false, user: action.user);
}

AuthState userAuthFailureReducer(AuthState auth, LoginFailure action) {
  return auth.copyWith(
      isAuthenticated: false, isAuthenticating: false, error: action.error);
}

AuthState userLogoutReducer(AuthState auth, UserLogout action) {
  return new AuthState();
}
