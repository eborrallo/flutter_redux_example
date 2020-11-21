import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/config/styles/colors.dart';
import 'package:flutter_redux_boilerplate/core/screens/auth/auth_actions.dart';
import 'package:flutter_redux_boilerplate/main.dart';


class LoadingScreen extends StatelessWidget {
  LoadingScreen({Key key}) : super(key: key);
  
  Widget build(BuildContext context) {
    store.dispatch(new IsAuthenticifated());
    return new MaterialApp(
      home: new Scaffold(
        body: new Center(
          child: new CircularProgressIndicator(
              backgroundColor: colorStyles['gray'], strokeWidth: 2.0),
        ),
      ),
    );
  }
}
