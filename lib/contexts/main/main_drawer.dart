import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_boilerplate/contexts/auth/auth_actions.dart';
import 'package:flutter_redux_boilerplate/redux/app_state.dart';
import 'package:flutter_redux_boilerplate/styles/colors.dart';

class MainDrawer extends StatelessWidget {
    
    MainDrawer({Key key}): super(key: key);

    @override
    Widget build(BuildContext context) {
        return new StoreConnector<AppState, dynamic>(
            converter: (store) => (BuildContext context) { store.dispatch(new UserLogout()); },
            builder: (BuildContext context, logout) => new Drawer(
                child: new ListView(
                    children: <Widget>[
                    new Container(
                        height: 120.0,
                        child: new DrawerHeader(
                        padding: new EdgeInsets.all(0.0),
                        decoration: new BoxDecoration(
                            color: new Color(0xFFECEFF1),
                        ),
                        child: new Center(
                            child: new FlutterLogo(
                            colors: colorStyles['primary'],
                            size: 54.0,
                            ),
                        ),
                        ),
                    ),
                    new ListTile(
                        leading: new Icon(Icons.chat),
                        title: new Text('Support'),
                        onTap: () => print('you pressed support')
                    ),
                    new ListTile(
                        leading: new Icon(Icons.info),
                        title: new Text('About'),
                        onTap: () => print('you pressed about')
                    ),
                    new Divider(),
                    new ListTile(
                        leading: new Icon(Icons.exit_to_app),
                        title: new Text('Sign Out'),
                        onTap: () => logout(context)
                    ),
                    ],
                )
            )
        );
    }

}