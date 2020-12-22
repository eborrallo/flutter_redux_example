import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/notifier/TaskNotifier.dart';

import 'package:flutter_redux_boilerplate/presentation/widgets/animated_list_item.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/task_card.dart';

class TaskTab extends StatefulWidget {
  TaskTab({
    Key key,
    this.taskNotifier,
  }) : super(key: key);
  final TaskNotifier taskNotifier;

  @override
  TaskTabState createState() => TaskTabState();
}

class TaskTabState extends State<TaskTab> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var tomorrow = now.add(Duration(days: 1));
    var upcoming = tomorrow.add(Duration(days: 1));
    List list = widget.taskNotifier.showOld
        ? (widget.taskNotifier.allTasks ?? [])
        : widget.taskNotifier.tasks ?? [];

    return new Container(
      alignment: Alignment.topLeft,
      color: Color.fromRGBO(245, 245, 245, 1),
      padding: EdgeInsets.only(top: 20),
      child: new ListView(
        controller: _scrollController,
        children: [
          widget.taskNotifier.showOld
              ? _oldest(widget.taskNotifier.oldest)
              : Container(),
          _today(widget.taskNotifier.today),
          _tomorrow(widget.taskNotifier.tomorrow),
          _upcomming(widget.taskNotifier.upComing)
        ],
      ),
    );
  }

  Widget _tackCollection(String title, List list, {Widget widget}) {
    return new Container(
        child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
          widget ?? Container()
        ]),
        this._buildAlmostDueList(list)
      ],
    ));
  }

  Widget showHideOldest() {
    return new Padding(
        padding: EdgeInsets.only(right: 21.0),
        child: FlatButton.icon(
          icon:
              Icon(widget.taskNotifier.showOld ? Icons.update : Icons.history),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          color: Colors.transparent,
          onPressed: () {
            widget.taskNotifier.toggleShowOld();

            _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          },
          label: new Text(
            widget.taskNotifier.showOld ? 'Hidde old' : 'Show old',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
  }

  Widget _oldest(List list) {
    return _tackCollection('Oldest', list, widget: showHideOldest());
  }

  Widget _today(List list) {
    return _tackCollection('Today', list, widget: showHideOldest());
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
            children: List.generate(
                list.length ?? 0,
                (i) => AnimatedListItem(
                      i,
                      new TaskCard(list[i], blockEdit: false),
                      duration: Duration(milliseconds: 400),
                    ))));
  }
}
