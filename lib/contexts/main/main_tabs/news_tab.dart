import 'package:flutter/material.dart';

class NewsTab extends StatelessWidget {
  NewsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Color.fromRGBO( 245, 245, 245,1),
        child: Center(
          child: new Text('news'),
        ));
  }
}
