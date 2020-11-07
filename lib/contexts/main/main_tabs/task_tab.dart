import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/animated_list_item.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/task_card.dart';

class TaskTab extends StatelessWidget {
  TaskTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.topLeft,
        color: Color.fromRGBO(245, 245, 245, 1),
        padding: EdgeInsets.only(top: 20),
        child: new ListView(
          children: [_today(), _tomorrow(), _upcomming()],
        ));
  }

  Widget _tackCollection(String title) {
    return new Container(
        child: Column(
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
        this._buildAlmostDueList()
      ],
    ));
  }

  Widget _today() {
    return _tackCollection('Today');
  }

  Widget _tomorrow() {
    return _tackCollection('Tomorrow');
  }

  Widget _upcomming() {
    return _tackCollection('Upcomming');
  }

  Widget _buildAlmostDueList() {
    return new Container(
        margin: EdgeInsets.symmetric(vertical: 21.0),
        padding: EdgeInsets.symmetric(horizontal: 21.0),
        height: 230.0,
        child: Column(
            children: List.generate(
                2, (i) => new AnimatedListItem(i, new TaskCard()))));
  }
}
