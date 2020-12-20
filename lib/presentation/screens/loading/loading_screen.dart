import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/config/styles/colors.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
 
 
  Widget build(BuildContext context) {
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
