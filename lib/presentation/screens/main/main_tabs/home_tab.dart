import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/TaskNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/animated_list_item.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/circular_progress_item.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/task_card.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TaskNotifier>(context, listen: true);

    return new Container(
        alignment: Alignment.topLeft,
        color: Color.fromRGBO(245, 245, 245, 1),
        child: new ListView(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _onProgress(),
            _almostDue(list.almostDue),
            _todayClass()
          ])
        ]));
  }

  Widget _todayClass() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: EdgeInsets.only(left: 21.0, top: 0),
          child: new Text(
            'Today Calss',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        this._buildTodayClass()
      ],
    );
  }

  Widget _buildTodayClass() {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      height: 150.0,
      child: ListView(
          padding: EdgeInsets.only(left: 21.0),
          scrollDirection: Axis.horizontal,
          children: List.generate(
              5,
              (i) => new AnimatedListItem(
                  i,
                  Container(
                      width: 300,
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Center(
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        new ListTile(
                                          title: Text(
                                            'Algorithm',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.grey,
                                                  size: 18,
                                                ),
                                                Text(
                                                  'Room 3A',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Text('08:00 - 10:00',
                                                        textAlign:
                                                            TextAlign.right))
                                              ])),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                new Icon(
                                                  Icons.error_outline,
                                                  color: Colors.orange,
                                                  size: 18,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  'You have one incpmplete task',
                                                  textAlign: TextAlign.right,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.orange),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                              ],
                                            )),
                                      ])))))))),
    );
  }

  Widget _almostDue(List<Task> list) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: EdgeInsets.only(left: 21.0, top: 20),
          child: new Text(
            'Almost Due',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        this._buildAlmostDueList(list)
      ],
    );
  }

  Widget _onProgress() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: EdgeInsets.only(left: 21.0, top: 21),
          child: new Text(
            'On progress',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        this._buildOnProgressList()
      ],
    );
  }

//
  Widget _buildAlmostDueList(List<Task> list) {
    return new Container(
        margin: EdgeInsets.symmetric(vertical: 21.0),
        padding: EdgeInsets.symmetric(horizontal: 21.0),
        height: 230.0,
        child: Column(
            children: list == null
                ? []
                : List.generate(list.length,
                    (i) => new AnimatedListItem(i, new TaskCard()))));
  }

  Widget _buildOnProgressList() {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      height: 100.0,
      child: ListView(
          padding: EdgeInsets.only(left: 21.0),
          scrollDirection: Axis.horizontal,
          children: List.generate(
              5,
              (i) => new AnimatedListItem(
                  i,
                  new CircularProgresItem(
                    text: 'Algoritm',
                    progressValue: i * 20,
                  )))),
    );
  }
}
