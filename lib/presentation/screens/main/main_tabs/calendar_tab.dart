import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/presentation/screens/main/main_tabs/profile_tab.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/animated_list_item.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/calendar.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/table_calendar/calendar.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/table_calendar/calendar_controller.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/table_calendar/customization/calendar_builders.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/table_calendar/customization/calendar_style.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/table_calendar/customization/days_of_week_style.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/table_calendar/customization/header_style.dart';
import 'package:intl/intl.dart';

class CalendarTab extends StatefulWidget {
  CalendarTab({
    Key key,
    this.appNotifier,
  }) : super(key: key);
  final AppNotifier appNotifier;

  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab>
    with TickerProviderStateMixin {
  TableCalendarController _calendarController;
  AnimationController _animationController;
  Map<DateTime, List<Task>> _events;
  List<Task> _selectedDayTasks = [];
  @override
  void initState() {
    super.initState();
    _events = Map();

    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        _events = widget.appNotifier.calendarEvents ?? [];
        _selectedDayTasks = _events != null
            ? _events[DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)]
            : [];
      });
    });

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
              child: Container(child: buildTableCalendar())),
        ),
        Expanded(
            flex: 1,
            child: ClipPath(
              clipper: new CustomHalfCircleClipper(
                  radius: 35, radiusLite: 10, arc: 1.05, arcLite: 1),
              child: Container(
                color: Colors.blue,
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Your Task',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 16.0),
                            padding: EdgeInsets.only(bottom: 20),
                            height: 160.0,
                            child: ListView(
                                padding: EdgeInsets.only(left: 21.0),
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                    _selectedDayTasks != null
                                        ? _selectedDayTasks.length
                                        : 0,
                                    (i) => new AnimatedListItem(
                                          i,
                                          buildListTask(_selectedDayTasks[i]),
                                          duration: Duration(milliseconds: 500),
                                        )))))
                  ],
                ),
              ),
            ))
      ],
    );
  }

  Widget buildListTask(Task _task) {
    return Container(
        width: 280,
        margin: EdgeInsets.only(bottom: 10.0),
        child: Center(
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent.shade100,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Due Time',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Text(
                            _task.deliveryDate.hour.toString() +
                                ":" +
                                _task.deliveryDate.minute.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Center(
                                  child: Text(
                                _task.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey,
                                    fontSize: 18),
                              ))),
                          Expanded(
                              flex: 1,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      margin: EdgeInsets.only(right: 10.0),
                                      decoration: new BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Flexible(
                                        child: Text(
                                      _task.subject.title.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey),
                                    ))
                                  ]))
                        ],
                      ),
                    ),
                  )
                ]))));
  }

  buildTableCalendar() {
    return Calendar(
      locale: 'es_ES',
      events: _events,
      calendarController: _calendarController,
      onDaySelected: _onDaySelected,
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
          headerMargin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor)))),
      builders: CalendarBuilders(
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 40,
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          return children;
        },
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
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(
                            6.0) //                 <--- border radius here
                        )),
                width: 50,
                height: 50,
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle().copyWith(
                        fontSize: 16.0,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.black
            : _calendarController.isToday(date)
                ? Colors.black
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    setState(() {
      _selectedDayTasks = events.length > 0 ? events : [];
    });
  }
}
