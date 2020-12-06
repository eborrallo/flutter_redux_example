import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/config/screens.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/platform_adaptive.dart';
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
                    getDaysOfWeek().map((date) => loadDay(date)).toList())));
  }

  List<Widget> loadItemsDay() {
    TextStyle hourStyle = TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
    return List.generate(
        2,
        (i) => Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Center(
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(children: [
                      Container(
                        width: 100,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('09:00', style: hourStyle),
                            Text(
                              '10:00',
                              style: hourStyle,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ListTile(
                                title: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Algorithm',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                                subtitle: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Location',
                                      ),
                                      Text(
                                        'Lecturers',
                                      )
                                    ],
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        Text('Room 5A',
                                            textAlign: TextAlign.right)
                                      ])),
                                  Text('')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                    ])))));
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

  List<String> getDaysOfWeek([String locale]) {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (index) => index)
        .map((value) => DateFormat(DateFormat.WEEKDAY, locale)
            .format(firstDayOfWeek.add(Duration(days: value))))
        .toList();
  }
}
