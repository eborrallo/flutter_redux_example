import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/config/screens.dart';
import 'package:flutter_redux_boilerplate/config/styles/colors.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Drawer(
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
            leading: new Icon(Icons.home),
            title: new Text('Home'),
            onTap: () => print('Home')),
        new ListTile(
            leading: new Icon(Icons.timeline),
            title: new Text('Timetable'),
            onTap: () => print("Timetable")),
        new ListTile(
            leading: new Icon(Icons.assignment),
            title: new Text('Subjects'),
            onTap: () => print('you pressed about')),
        new ListTile(
            leading: new Icon(Icons.assignment_ind),
            title: new Text('Lecturers'),
            onTap: () => print('you pressed about')),
        new Divider(),
        new ListTile(
            leading: new Icon(Icons.exit_to_app),
            title: new Text('Sign Out'),
            onTap: () => print('Sign out')),
      ],
    ));
  }
}