import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';

class AllTasksDone extends StatefulWidget {
  final List<Task> tasks;
  AllTasksDone(this.tasks);
  @override
  _AllTasksDoneState createState() => _AllTasksDoneState();
}

class _AllTasksDoneState extends State<AllTasksDone>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    int pendingOldTask =
        widget.tasks.where((element) => !element.done).toList().length;
    return FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
        child: Center(
          child: Column(children: [
            Text(
              pendingOldTask > 0 ? '😇' : '😍',
              style: TextStyle(fontSize: 100),
            ),
            AutoSizeText(
              (pendingOldTask > 0
                  ? 'All the next task are done.But some of the old tasks haven\'t yet'
                  : 'All the task are done'),
              maxLines: 2,
              maxFontSize: 40,
              minFontSize: 25,
              textAlign: TextAlign.center,
              //style: TextStyle(fontSize: 40),
            )
          ]),
        ));
  }
}
