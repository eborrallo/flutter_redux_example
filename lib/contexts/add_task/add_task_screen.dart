import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/containers/platform_adaptive.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskStateScreen createState() => _AddTaskStateScreen();
}

class _AddTaskStateScreen extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new PlatformAdaptiveAppBar(
          title: Text(
            'Add Task',
            style: TextStyle(color: Colors.black),
          ),
          platform: Theme.of(context).platform,
          backgroundColor: Color.fromRGBO(245, 245, 245, 1),
          leading: BackButton(color: Colors.black),
        ),
        body: Container(
          color: Colors.blue,
        ));
  }
}
