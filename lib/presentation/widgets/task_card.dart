import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/TaskNotifier.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  bool blockEdit;
  TaskCard(this.task, {this.blockEdit = true});

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  Timer _timer;
  String totalTimeLeft;

  String formatTimeLeft(int durationMinutes) {
    Duration duration = new Duration(minutes: durationMinutes);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitMinutes = twoDigits(duration.inHours.remainder(24));
    return "${twoDigitMinutes}h ${twoDigitHours}m";
  }

  @override
  void didUpdateWidget(TaskCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Duration timeLeft(DateTime deliveryTime) {
    DateTime now = new DateTime.now();
    Duration difference = deliveryTime.difference(now);
    return difference;
  }

  void startTimer() {
    totalTimeLeft = timeLeft(widget.task.deliveryDate).inMinutes.toString();

    const oneMin = const Duration(minutes: 1);
    _timer = new Timer.periodic(
      oneMin,
      (Timer timer) {
        totalTimeLeft = timeLeft(widget.task.deliveryDate).inMinutes.toString();

        if (int.parse(totalTimeLeft) <= 0) {
          if (this.mounted) {
            setState(() {
              timer.cancel();
            });
          }
        } else {
          if (this.mounted) {
            setState(() {
              totalTimeLeft = (int.parse(totalTimeLeft) - 1).toString();
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: widget.blockEdit ? widget.task.done : false,
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
                          value: widget.task.done,
                          activeColor: Color(0xffFFBD11),
                          onChanged: (bool value) async {
                            if (this.mounted) {
                              if (!value && widget.blockEdit) {
                              } else {
                                context
                                    .read<TaskNotifier>()
                                    .toggleTask(widget.task.uuid);
                              }
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
                                      Text(
                                          formatTimeLeft(
                                              int.parse(totalTimeLeft)),
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
