import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Color.fromRGBO( 245, 245, 245,1),
        child: Center(
          child: new Text('profile'),
        ));
  }
}
