import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/auth/login/login_screen.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/platform_adaptive.dart';

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
    return new Form(
      key: formKey,
      child: new Column(
        children: [
          new TextFormField(
            controller: TextEditingController(),
            decoration: new InputDecoration(labelText: 'Username'),
            validator: (val) =>
                val.isEmpty ? 'Please enter your username.' : null,
            onSaved: (val) => _username = val,
          ),
          new TextFormField(
            controller: TextEditingController(),
            decoration: new InputDecoration(labelText: 'Password'),
            validator: (val) =>
                val.isEmpty ? 'Please enter your password.' : null,
            onSaved: (val) => _password = val,
            obscureText: true,
          ),
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
                        },
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        child: new Text('Sign in'),
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
  }
}
