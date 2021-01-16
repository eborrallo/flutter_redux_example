import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/extensions/color_extension.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/task/details_task_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  Function callback;
  bool blockEdit;
  TaskCard(this.task, {this.blockEdit = true, this.callback});

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  Timer _timer;
  String totalTimeLeft;

  String formatTimeLeft(int durationMinutes) {
    Duration duration = new Duration(minutes: durationMinutes);

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitDays = duration.inDays.toString();
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));

    if (duration.inDays > 0) {
      return "${twoDigitDays}d ${twoDigitHours}h ${twoDigitMinutes}m";
    }
    if (int.parse(twoDigitHours) <= 0 &&
        int.parse(twoDigitDays) <= 0 &&
        int.parse(twoDigitMinutes) <= 0) {
      DateTime now =
          DateTime.now().subtract(Duration(minutes: -durationMinutes));

      if (now.day == DateTime.now().day &&
          now.month == DateTime.now().month &&
          now.year == DateTime.now().year) {
        return 'Expired from ' + DateFormat.Hm().format(now);
      }
      return DateFormat.yMMMd().format(now);
    }
    return "${twoDigitHours}h ${twoDigitMinutes}m";
  }

  @override
  void didUpdateWidget(TaskCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    startTimer();
  }

  @override
  void initState() {
    startTimer();

    super.initState();
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

  void _displayBottomSheet(BuildContext context) {
    context.read<AppNotifier>().floatActionButtonKey.currentState.close();
    showModalBottomSheet(
        context: context,
        //isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (ctx) {
          return DetailsTaskScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    AppNotifier app = getIt<AppNotifier>();

    return GestureDetector(
        onTap: () {
          app.selectTask(widget.task);
          _displayBottomSheet(context);
        },
        child: //widget.blockEdit ? widget.task.done : false,
            Container(
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
                                    app.toggleTask(widget.task.uuid);
                                    if (widget.callback != null) {
                                      widget.callback();
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                          title: AutoSizeText(
                            widget.task.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
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
                                        color: HexColor.fromHex(
                                            widget.task.subject.color),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: AutoSizeText(
                                          widget.task.subject.title,
                                          maxLines: 1,
                                          //maxFontSize: 15,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                int.parse(totalTimeLeft) <= 0
                                                    ? Icons.watch_later
                                                    : Icons.access_time,
                                                size: 18,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                formatTimeLeft(
                                                    int.parse(totalTimeLeft)),
                                                textAlign: TextAlign.right,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ]))
                                  ])),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
