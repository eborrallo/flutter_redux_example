import 'package:flutter/material.dart';

class TaskTab extends StatelessWidget {
  TaskTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Color.fromRGBO(245, 245, 245, 1),
        child: new Center(
          child: new Text('task'),
        ));
  }
}
