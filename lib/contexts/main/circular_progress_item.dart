import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularProgresItem extends StatefulWidget {
  CircularProgresItem({this.text, this.progressValue});

  @override
  _CircularProgresItemState createState() => _CircularProgresItemState();
  String text;
  int progressValue;
}

class _CircularProgresItemState extends State<CircularProgresItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0),
      margin: EdgeInsets.only(right: 30.0),
      child: CircularPercentIndicator(
        animationDuration: 200,
        animateFromLastPercent: true,
        backgroundColor: Colors.black12,
        percent: widget.progressValue / 100,
        animation: true,
        radius: 55.0,
        lineWidth: 4.0,
        center: new Text(
          widget.progressValue.toString(),
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.black54),
        ),
        footer: new Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: new Text(
              widget.text,
              style: new TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0),
            )),
        linearGradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.purple]),
      ),
    );
  }
}
