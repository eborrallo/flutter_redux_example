import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/TaskNotifier.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final String timeLeft;

  TaskCard(this.task, this.timeLeft);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool radiovalue = false;
  

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: radiovalue,
        child: Container(
            height: 100,
            margin: EdgeInsets.only(bottom: 10.0),
            child: Center(
              child: Card(
                semanticContainer: false,
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
                        child: Checkbox(
                          value: radiovalue,
                          activeColor: Color(0xffFFBD11),
                          onChanged: (bool value) async {
                            if (this.mounted) {
                              setState(() {
                                radiovalue = true;
                              });
                              await Future.delayed(Duration(milliseconds: 300),
                                  () {
                                if (this.mounted) {
                                  context
                                      .read<TaskNotifier>()
                                      .taskDone(widget.task.uuid);
                                }
                              });
                              await Future.delayed(Duration(milliseconds: 100),
                                  () {
                                if (this.mounted) {
                                  setState(() {
                                    radiovalue = false;
                                  });
                                }
                              });
                            }
                          },
                        ),
                      ),
                      title: Text(
                        widget.task.title,
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
                                  widget.task.subject.title,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Expanded(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                      Text(widget.timeLeft,
                                          textAlign: TextAlign.right)
                                    ]))
                              ])),
                    ),
                  ],
                ),
              ),
            )));
  }
}
