import 'package:flutter_redux_boilerplate/contexts/auth/login/login_action.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/services/FirebaseAuthentification.dart';
import 'package:flutter_redux_boilerplate/services/api_client.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';

@injectable
class AuthMiddleware {
  Auth auth;
  AuthMiddleware(this.auth);

  login(Store<AppState> store, action, NextDispatcher next) async {
    String aa = await ApiClient.getSomething();
    print('Sync: ' + aa);
    ApiClient.getSomething().then((value) => print('Async: ' + value));
    next(action);
  }
}

List<Middleware<AppState>> createStoreAuthMiddleware() {
  AuthMiddleware middleware = getIt<AuthMiddleware>();
  return [
    TypedMiddleware<AppState, LoginRequest>(middleware.login),
  ];
}
