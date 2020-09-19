import 'package:flutter_redux_boilerplate/contexts/auth/auth_actions.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/services/api_client.dart';
import 'package:redux/redux.dart';

 _getSomething() =>
   (Store<AppState> store,  action, NextDispatcher next) async {
    String aa= await ApiClient.getSomething();
    print('Sync: '+aa);
    ApiClient.getSomething().then((value) =>  print('Async: '+value));
    next(action);
  };

List<Middleware<AppState>> createStoreAuthMiddleware() {
  final loginInit = _getSomething();

  return [
    TypedMiddleware<AppState, UserLoginRequest>(loginInit),

  ];
}