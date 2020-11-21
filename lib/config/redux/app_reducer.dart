import 'package:flutter_redux_boilerplate/config/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/auth_reducer.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/sign_up/sign_up_reducer.dart';


AppState appReducer(AppState state, action) {

  return new AppState(
      auth: authReducer(state.auth, action),
      signUp: signUpReducer(state.signUp, action)
  );
}
