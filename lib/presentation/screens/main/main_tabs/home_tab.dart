import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/presentation/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/circular_progress_item.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/class_card.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/reactive_animated_list.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/task_card.dart';

class HomeTab extends StatelessWidget {
  final AppNotifier appNotifier;
  final changeTab;

  HomeTab({Key key, this.appNotifier, this.changeTab})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.topLeft,
        color: Color.fromRGBO(245, 245, 245, 1),
        child: new ListView(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _onProgress(appNotifier.onProgress),
            _almostDue(appNotifier.almostDue),
            _todayClass(appNotifier.todayClasses)
          ])
        ]));
  }

  Widget _todayClass(List<TodayClass> list) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: EdgeInsets.only(left: 21.0, top: 0),
          child: new Text(
            'Today Class',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        this._buildTodayClass(list)
      ],
    );
  }

  Widget _buildTodayClass(List<TodayClass> list) {
    return new Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        height: 150.0,
        child: new ReactiveAnimatedList(
          list,
          (context, element) => ClassCard(element),
          length: list != null ? list.length : 0,
          scrollDirection: Axis.horizontal,
        ));
  }

  Widget _almostDue(List<Task> list) {
    List doneList =
        list != null ? list.where((element) => !element.done).toList() : [];
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
            padding: EdgeInsets.only(left: 21.0, top: 20, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Text(
                  'Almost Due',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                doneList.length > 2
                    ? FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.transparent,
                        onPressed: () {
                          this.changeTab(1);
                        },
                        child: new Text(
                          'Show all',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : Container(),
              ],
            )),
        this._buildAlmostDueList(list)
      ],
    );
  }

  Widget _onProgress(List<SubjectProgress> list) {
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
        this._buildOnProgressList(list)
      ],
    );
  }

  Widget _buildAlmostDueList(List<Task> list) {
    return new Container(
        margin: EdgeInsets.symmetric(vertical: 21.0),
        padding: EdgeInsets.symmetric(horizontal: 21.0),
        height: 230.0,
        child: ReactiveAnimatedList(
          list,
          (context, element) => new TaskCard(
            element,
          ),
          length: 2,
        ));
  }

  Widget _buildOnProgressList(List<SubjectProgress> list) {
    return new Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        height: 101.0,
        child: new ReactiveAnimatedList(
          list,
          (context, element) => new CircularProgresItem(
            text: element.title,
            progressValue: element.progress,
          ),
          scrollDirection: Axis.horizontal,
          length: list != null ? list.length : 0,
        ));
  }
}
