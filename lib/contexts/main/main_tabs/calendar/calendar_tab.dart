import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/contexts/main/main_tabs/profile_tab.dart';

import 'package:flutter_redux_boilerplate/contexts/main/widgets/calendar.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/table_calendar/calendar.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/table_calendar/calendar_controller.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/table_calendar/customization/calendar_builders.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/table_calendar/customization/calendar_style.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/table_calendar/customization/days_of_week_style.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/table_calendar/customization/header_style.dart';
import 'package:intl/intl.dart';

class CalendarTab extends StatefulWidget {
  CalendarTab({Key key}) : super(key: key);

  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab>
    with TickerProviderStateMixin {
  DateTime _currentDate = DateTime.now();

  TableCalendarController _calendarController;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _calendarController = TableCalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
              color: Color.fromRGBO(245, 245, 245, 1),
              child: Container(
                  child: buildTableCalendar())),
        ),
        Expanded(
            child: ClipPath(
          clipper: new CustomHalfCircleClipper(
              radius: 35, radiusLite: 10, arc: 1.05, arcLite: 1),
          child: Container(
            color: Colors.blue,
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Your Task')
                  ],
                )
              ],
            ),
          ),
        ))
      ],
    );
  }

  buildTableCalendar() {
    return Calendar(
      locale: 'es_ES',
      calendarController: _calendarController,
      initialCalendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        weekendStyle: TextStyle().copyWith(color: Colors.red[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextBuilder: (date, locale) =>
            DateFormat.E(locale).format(date)[0].toUpperCase() +
            DateFormat.E(locale).format(date)[1],
        weekendStyle: TextStyle().copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blue[600]),
        weekdayStyle: TextStyle().copyWith(
            fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black38),
      ),
      headerStyle: HeaderStyle(
          centerHeaderTitle: true,
          formatButtonVisible: false,
          headerMargin:EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor)))),
      builders: CalendarBuilders(
        dayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              width: 50,
              height: 50,
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(
                          6.0) //                 <--- border radius here
                      ),
                ),
                width: 50,
                height: 50,
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle().copyWith(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              width: 50,
              height: 50,
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
