import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/aut_thunk.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_boilerplate/models/user.dart';



class UserLoginRequest {
  UserLoginRequest(Store<dynamic> store, username, password) {
          store.dispatch(getSomething());
  }
}

class UserLoginSuccess {
    final User user;

    UserLoginSuccess(this.user);
}

class UserLoginFailure {
    final String error;

    UserLoginFailure(this.error);
}

class UserLogout {}

final Function login = (BuildContext context, String username, String password) {
    return (Store<AppState> store) {
       // store.dispatch(new UserLoginRequest());
        if (username == 'asd' && password == 'asd') {
            store.dispatch(new UserLoginSuccess(new User('placeholder_token', 'placeholder_id')));
            Navigator.of(context).pushNamedAndRemoveUntil('/main', (_) => false);
        } else {
            store.dispatch(new UserLoginFailure('Username or password were incorrect.'));
        }
    };
};

final Function logout = (BuildContext context) {
    return (Store<AppState> store) {
        store.dispatch(new UserLogout());
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
    };
};

