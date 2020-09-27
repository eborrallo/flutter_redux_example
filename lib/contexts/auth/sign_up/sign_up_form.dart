import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_boilerplate/containers/platform_adaptive.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/auth_actions.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/sign_up/sign_up_actions.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:redux/redux.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => new _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = new GlobalKey<FormState>();

  String _username;
  String _password;
  String _confirm_passw;

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
          store.dispatch(new UserSignUpRequest( username, password));
    }, builder: (BuildContext context, signUpAction) {
      return new Form(
        key: formKey,
        child: new Column(
          children: [
            new TextFormField(
              decoration: new InputDecoration(labelText: 'Username'),
              validator: (val) =>
                  val.isEmpty ? 'Please enter your username.' : null,
              onSaved: (val) => _username = val,
            ),
            new TextFormField(
              decoration: new InputDecoration(labelText: 'Password'),
              validator: (val) =>
                  val.isEmpty ? 'Please enter your password.' : null,
              onSaved: (val) => _password = val,
              obscureText: true,
            ),
            new TextFormField(
              decoration: new InputDecoration(labelText: 'CONFIRM Password'),
              validator: (val) =>
                  val.isEmpty ? 'Please enter your password again.' : null,
              onSaved: (val) => _confirm_passw = val,
              obscureText: true,
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20.0),
              child: new PlatformAdaptiveButton(
                onPressed: () {
                  _submit();
                  signUpAction(context, _username, _password);
                },
                icon: new Icon(Icons.done),
                child: new Text('Register'),
              ),
            )
          ],
        ),
      );
    });
  }
}
