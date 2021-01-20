import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/notifier/TaskNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/subject/subject_list.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/animated_list_item.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/task_card.dart';
import 'package:flutter_redux_boilerplate/config/i18n.dart';

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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(245, 245, 245, 1),
              flexibleSpace: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  new TabBar(
                    indicatorColor: Colors.blue,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      new Tab(icon: new Icon(Icons.assignment_turned_in)),
                      new Tab(icon: new Icon(Icons.assignment)),
                    ],
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              new Container(
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
              ),
              new Container(
                child: SubjectListScreen(),
              )
            ])));
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
            widget.taskNotifier.showOld ? 'Hidde old'.i18n : 'Show old'.i18n,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
  }

  Widget _oldest(List list) {
    return _tackCollection('Oldest'.i18n, list, widget: showHideOldest());
  }

  Widget _today(List list) {
    return _tackCollection('Today'.i18n, list, widget: showHideOldest());
  }

  Widget _tomorrow(List list) {
    return _tackCollection('Tomorrow'.i18n, list);
  }

  Widget _upcomming(List list) {
    return _tackCollection('Upcomming'.i18n, list);
  }

  Widget _buildAlmostDueList(List list) {
    return Container(
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
