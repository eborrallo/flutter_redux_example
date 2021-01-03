import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/extensions/date_time_extension.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/platform_adaptive.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/timetable_card.dart';
import 'package:intl/intl.dart';

class ListTimetableScreen extends StatefulWidget {
  @override
  _ListTimetableScreenState createState() => _ListTimetableScreenState();
}

class _ListTimetableScreenState extends State<ListTimetableScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: new PlatformAdaptiveAppBar(
          actions: ([
            IconButton(
                color: Colors.black, icon: Icon(Icons.search), onPressed: () {}),
            IconButton(
                color: Colors.black, icon: Icon(Icons.add), onPressed: () {})
          ]),
          title: Text(
            'Timetable',
            style: TextStyle(color: Colors.black),
          ),
          platform: Theme.of(context).platform,
          backgroundColor: Color.fromRGBO(245, 245, 245, 1),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);

            },
          ),
        ),
        body: Container(
            color: Color.fromRGBO(245, 245, 245, 1),
            padding: EdgeInsets.all(20),
            child: ListView(
                children:
                    DateWeekExtensions.getDaysOfWeek().map((date) => loadDay(date)).toList())));
  }

  List<Widget> loadItemsDay() {
  
    return List.generate(
        2,
        (i) => TimetableCard());
  }

  Widget loadDay(day) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            day.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]..addAll(loadItemsDay()),
    );
  }
}
