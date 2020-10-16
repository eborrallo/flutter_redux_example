import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/login/login_action.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_boilerplate/models/user.dart';


class UserLogout {}

final Function login = (BuildContext context, String username, String password) {
    return (Store<AppState> store) {
       // store.dispatch(new UserLoginRequest());
        if (username == 'asd' && password == 'asd') {
            store.dispatch(new LoginSuccess(new User('placeholder_token', 'placeholder_id')));
            Navigator.of(context).pushNamedAndRemoveUntil('/main', (_) => false);
        } else {
            store.dispatch(new LoginFailure('Username or password were incorrect.'));
        }
    };
};

final Function logout = (BuildContext context) {
    return (Store<AppState> store) {
        store.dispatch(new UserLogout());
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
    };
};

