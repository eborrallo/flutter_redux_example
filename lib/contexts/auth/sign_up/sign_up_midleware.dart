import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/services/api_client.dart';
import 'package:flutter_redux_boilerplate/services/firebase/FirebaseAuthentification.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';

import 'sign_up_actions.dart';

@injectable
class SignUpMiddleware {
  Auth auth;
  SignUpMiddleware(this.auth);

  signUp(Store<AppState> store, UserSignUpRequest action,
      NextDispatcher next) async {
    //String aa= await ApiClient.getSomething();

    this
        .auth
        .registerWithEmailAndPassword(action.username, action.password)
        .then((value) {
          store.dispatch(  new SignUpSuccess(action.username, action.password));
          })
        .catchError((onError) {
      print(onError);
    });
    next(action);
  }
}

List<Middleware<AppState>> createStoreSignUpMiddleware() {
  SignUpMiddleware middleware = getIt<SignUpMiddleware>();
  return [
    TypedMiddleware<AppState, UserSignUpRequest>(middleware.signUp),
  ];
}
