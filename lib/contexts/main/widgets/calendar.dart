import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/table_calendar/calendar.dart';

class Calendar extends TableCalendar {
  Calendar(
      {Key key,
      calendarController,
      locale,
      initialCalendarFormat,
      availableCalendarFormats,
      startingDayOfWeek,
      calendarStyle,
      daysOfWeekStyle,
      headerStyle,
      builders})
      : super(
          key: key,
          calendarController: calendarController,
          locale: locale,
          initialCalendarFormat: initialCalendarFormat,
          availableCalendarFormats: availableCalendarFormats,
          startingDayOfWeek: startingDayOfWeek,
          calendarStyle: calendarStyle,
          daysOfWeekStyle: daysOfWeekStyle,
          headerStyle: headerStyle,
          builders: builders,
        );
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends TableCalendarState {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.headerVisible) buildHeader(),
          Padding(
            padding: widget.calendarStyle.contentPadding,
            child: buildCalendarContent(),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildHeader() {
    return Text('el pepe');
  }
}
