import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_boilerplate/containers/platform_adaptive.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/login/login_action.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/login/login_screen.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:redux/redux.dart';
import '../../../redux/app_state.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = new GlobalKey<FormState>();

  String _username;
  String _password;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(
        converter: (Store<AppState> store) {
      return (BuildContext context, String username, String password) =>
          store.dispatch(new LoginRequest(username, password));
    }, builder: (BuildContext context, loginAction) {
      return new Form(
        key: formKey,
        child: new Column(
          children: [
            StoreConnector<AppState, String>(
                converter: (store) {
                  return store.state.signUp.username;
                },
                builder: (BuildContext context, username) => new TextFormField(
                      controller: TextEditingController(text: username),
                      decoration: new InputDecoration(labelText: 'Username'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your username.' : null,
                      onSaved: (val) => _username = val,
                    )),
            StoreConnector<AppState, String>(
                converter: (store) {
                  return store.state.signUp.password;
                },
                builder: (BuildContext context, password) => new TextFormField(
                      controller: TextEditingController(text: password),
                      decoration: new InputDecoration(labelText: 'Password'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your password.' : null,
                      onSaved: (val) => _password = val,
                      obscureText: true,
                    )),
            new Padding(
                padding: new EdgeInsets.only(top: 20.0),
                child: SizedBox(
                    width: double.infinity,
                    child: CustomElevation(
                      child: new FlatButton(
                          color: Colors.white,
                          textColor: Colors.black,
                          onPressed: () {
                            _submit();
                            loginAction(context, _username, _password);
                          },
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          child: new Text('Sign in '),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(7.0),
                          )),
                    ))),
            new Padding(
              padding: new EdgeInsets.only(top: 20.0),
              child: new PlatformAdaptiveButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/signUp");
                },
                icon: new Icon(Icons.done),
                child: new Text('Not member ? Sign up now'),
              ),
            )
          ],
        ),
      );
    });
  }
}
