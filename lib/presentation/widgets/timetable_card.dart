import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/class/class.dart';

class TimetableCard extends StatefulWidget {
  final TodayClass todayClass;

  TimetableCard({this.todayClass});
  @override
  _TimetableCardState createState() => _TimetableCardState();
}

class _TimetableCardState extends State<TimetableCard> {
  @override
  Widget build(BuildContext context) {
    TextStyle hourStyle = TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
    return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Center(
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius:
                            new BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(widget.todayClass.timeIn.toString(), style: hourStyle),
                        Text(
                          widget.todayClass.timeOut.toString(),
                          style: hourStyle,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ListTile(
                            title: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  widget.todayClass.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                            subtitle: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Location',
                                  ),
                                  Text(
                                    'Lecturers',
                                  )
                                ],
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    Text(widget.todayClass.location, textAlign: TextAlign.right)
                                  ])),
                              Text('')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
                ]))));
  }
}
