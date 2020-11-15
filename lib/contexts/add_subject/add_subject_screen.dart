import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/containers/platform_adaptive.dart';

class AddSubjectScreen extends StatefulWidget {
  @override
  _AddSubjectScreenState createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new PlatformAdaptiveAppBar(
          title: Text(
            'Add Subject',
            style: TextStyle(color: Colors.black),
          ),
          platform: Theme.of(context).platform,
          backgroundColor: Color.fromRGBO(245, 245, 245, 1),
          leading: BackButton(color: Colors.black),
        ),
        body: Container(
          color: Colors.purpleAccent,
        ));
  }
}
