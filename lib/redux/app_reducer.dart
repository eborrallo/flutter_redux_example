import 'package:flutter_redux_boilerplate/contexts/auth/auth_reducer.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/sign_up/sign_up_reducer.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:redux_persist/redux_persist.dart';

AppState appReducer(AppState state, action){
    //print(action);
    if (action is PersistLoadedAction<AppState>) {
        return action.state ?? state;
    } else {
        return new AppState(
            auth: authReducer(state.auth, action),
            signUp: signUpReducer(state.signUp, action),
        );
    }

} 