import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/services/api_client.dart';
import 'package:redux/redux.dart';

import 'sign_up_actions.dart';

 _getSomething() =>
   (Store<AppState> store, UserSignUpRequest action, NextDispatcher next) async {
    //String aa= await ApiClient.getSomething();
   // print('Sync: '+aa);
    ApiClient.getSomething().then((value) =>  store.dispatch(new SignUpSuccess(action.username, action.password)));
    next(action);
  };


List<Middleware<AppState>> createStoreSignUpMiddleware() {
  final loginInit = _getSomething();

  return [
    TypedMiddleware<AppState, UserSignUpRequest>(loginInit),
  ];
}