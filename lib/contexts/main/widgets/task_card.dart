import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new ListTile(
                leading: Transform.scale(
                  scale: 1.5,
                  child: Radio(
                    value: 0,
                    activeColor: Color(0xffFFBD11),
                  ),
                ),
                title: Text(
                  'Make and article',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            margin: EdgeInsets.only(right: 10.0),
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            'Networking',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Expanded(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                Icon(
                                  Icons.access_time,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                Text('9h 2m', textAlign: TextAlign.right)
                              ]))
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}