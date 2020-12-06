import 'package:flutter/material.dart';
import './login_form.dart' show LoginForm;


class CustomElevation extends StatelessWidget {
  final Widget child;

  CustomElevation({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: this.child,
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            child: new Padding(
                padding: new EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).padding.top + 32.0, 0, 32.0),
                child: new Column(children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Container(
                        height: 21,
                        width: 21,
                        margin: EdgeInsets.only(bottom: 7, right: 7),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      new Container(
                        height: 21,
                        width: MediaQuery.of(context).size.width * 0.4,
                        margin: EdgeInsets.only(bottom: 7),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.purple],
                            stops: [0.0, 1],
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(50.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.purple],
                            stops: [0.0, 1],
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(50.0),
                          ),
                        ),
                        child: new Text(
                          'CAMPUS PLANNER',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                  new Padding(
                      padding: new EdgeInsets.fromLTRB(30,
                          MediaQuery.of(context).padding.top + 32.0, 30, 32.0),
                      child: new Column(children: <Widget>[
                        SizedBox(
                            width: double.infinity,
                            child: CustomElevation(
                              child: new FlatButton.icon(
                                  icon: Icon(Icons.account_circle),
                                  color: Colors.white,
                                  textColor: Colors.black,
                                  onPressed: () {
                                  },
                                  padding: EdgeInsets.all(8.0),
                                  splashColor: Colors.blueAccent,
                                  label: new Text('Sign in with Google'),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(7.0),
                                  )),
                            )),
                        new Row(children: <Widget>[
                          Expanded(
                            child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 20.0),
                                child: Divider(
                                  color: Colors.grey,
                                  height: 36,
                                )),
                          ),
                          Text(
                            "OR",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Expanded(
                            child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 20.0, right: 10.0),
                                child: Divider(
                                  color: Colors.grey,
                                  height: 36,
                                )),
                          ),
                        ]),
                        LoginForm()
                      ])),
                ]))));
  }
}
