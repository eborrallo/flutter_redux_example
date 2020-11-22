import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_boilerplate/config/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/sign_up/sign_up_actions.dart';
import 'package:flutter_redux_boilerplate/core/widgets/platform_adaptive.dart';
import 'package:redux/redux.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => new _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
    final store = StoreProvider.of<AppState>(context);

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
            validator: (val) {
              _password = val;
              return val.isEmpty ? 'Please enter your password.' : null;
            },
            onSaved: (val) => _password = val,
            obscureText: true,
          ),
          new TextFormField(
            decoration: new InputDecoration(labelText: 'Confirm password'),
            validator: (val) {
              var message;
              message = message == null
                  ? val.isEmpty ? 'Please enter your password again.' : null
                  : message;
              message = message == null
                  ? _password != val ? 'Please enter the same password.' : null
                  : message;
              return message;
            },
            obscureText: true,
          ),
          new Padding(
            padding: new EdgeInsets.only(top: 20.0),
            child: new PlatformAdaptiveButton(
              onPressed: () {
                _submit();
                store.dispatch(new UserSignUpRequest(_username, _password));
              },
              icon: new Icon(Icons.done),
              child: new Text('Register'),
            ),
          )
        ],
      ),
    );
  }
}
