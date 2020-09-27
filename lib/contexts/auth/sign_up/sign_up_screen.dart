import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/login/login_form.dart';


import 'package:flutter_redux_boilerplate/styles/colors.dart';

import 'sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
    SignUpScreen({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            body: new Container(
                child: new Padding(
                    padding: new EdgeInsets.fromLTRB(32.0, MediaQuery.of(context).padding.top + 32.0, 32.0, 32.0),
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                            new Expanded(
                                child: new Center(
                                    child: new FlutterLogo(
                                        colors: colorStyles['primary'],
                                        size: 200.0,
                                    ),
                                ),
                            ),
                            new SignUpForm()
                        ],
                    )
                )
            )
        );
    }

}