import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';

class ClassCard extends StatefulWidget {
  final TodayClass todayClass;

  ClassCard(this.todayClass);

  @override
  _ClassCardState createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        margin: EdgeInsets.only(bottom: 10.0, left: 10),
        child: Center(
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new ListTile(
                            title: Text(
                              widget.todayClass.title,
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                  Text(
                                    widget.todayClass.location,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                          widget.todayClass.timeIn +
                                              ' - ' +
                                              widget.todayClass.timeOut,
                                          textAlign: TextAlign.right))
                                ])),
                          ),
                          widget.todayClass.message != null?
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      new Icon(
                                        Icons.error_outline,
                                        color: Colors.orange,
                                        size: 18,
                                      ),
                                      Expanded(
                                          child: Text(
                                        widget.todayClass.message,
                                        textAlign: TextAlign.right,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.orange),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ],
                                  )):Container(),
                        ])))));
  }
}