
import 'package:flutter_redux_boilerplate/core/screens/auth/sign_up/sign_up.state.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/sign_up/sign_up_actions.dart';
import 'package:redux/redux.dart';

Reducer<SignUpState> signUpReducer = combineReducers([
    new TypedReducer<SignUpState, SignUpSuccess>(userSigUpSuccessReducer),
]);

SignUpState userSigUpSuccessReducer(SignUpState signUp, SignUpSuccess action) {
    return signUp.copyWith(
        username: action.username,
        password: action.password
    );
}