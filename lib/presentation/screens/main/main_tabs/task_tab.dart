import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/TaskNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/animated_list_item.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/task_card.dart';

class TaskTab extends StatelessWidget {
  final TaskNotifier taskNotifier;
  TaskTab({Key key, this.taskNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var tomorrow = now.add(Duration(days: 1));
    var upcoming = tomorrow.add(Duration(days: 1));
    List listToday = taskNotifier.tasks ?? [];
    return new Container(
        alignment: Alignment.topLeft,
        color: Color.fromRGBO(245, 245, 245, 1),
        padding: EdgeInsets.only(top: 20),
        child: new ListView(
          children: [
            _today(listToday
                .where((element) => element.deliveryDate.day == now.day)
                .toList()),
            _tomorrow(listToday
                .where((element) => element.deliveryDate.day == tomorrow.day)
                .toList()),
            _upcomming(listToday
                .where((element) => element.deliveryDate.day > upcoming.day)
                .toList())
          ],
        ));
  }

  Widget _tackCollection(String title, List list) {
    return new Container(
        child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: EdgeInsets.only(left: 21.0),
          child: new Text(
            title,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        this._buildAlmostDueList(list)
      ],
    ));
  }

  Widget _today(List list) {
    return _tackCollection('Today', list);
  }

  Widget _tomorrow(List list) {
    return _tackCollection('Tomorrow', list);
  }

  Widget _upcomming(List list) {
    return _tackCollection('Upcomming', list);
  }

  Widget _buildAlmostDueList(List list) {
    return new Container(
        margin: EdgeInsets.symmetric(vertical: 21.0),
        padding: EdgeInsets.symmetric(horizontal: 21.0),
        child: Column(
            children: List.generate(list.length ?? 0,
                (i) => AnimatedListItem(i, TaskCard(list[i])))));
  }
}
