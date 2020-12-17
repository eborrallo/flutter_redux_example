import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/table_calendar/calendar.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/table_calendar/widgets/custom_icon_button.dart';
import 'package:intl/intl.dart';

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
      builders,
      onDaySelected,
      events})
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
            onDaySelected: onDaySelected,
            events: events);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends TableCalendarState {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  String inCap(String word) {
    return word[0].toUpperCase() + word.substring(1);
  }

  @override
  Widget buildHeader() {
    final children = [
      Expanded(
        child: GestureDetector(
            onTap: onHeaderTapped,
            onLongPress: onHeaderLongPressed,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.headerStyle.titleTextBuilder != null
                        ? widget.headerStyle.titleTextBuilder(
                            widget.calendarController.focusedDay, widget.locale)
                        : inCap(DateFormat.LLLL(widget.locale)
                            .format(widget.calendarController.focusedDay)),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: widget.headerStyle.centerHeaderTitle
                        ? TextAlign.center
                        : TextAlign.start,
                  ),
                  Text(
                    widget.headerStyle.titleTextBuilder != null
                        ? widget.headerStyle.titleTextBuilder(
                            widget.calendarController.focusedDay, widget.locale)
                        : ' ' +
                            DateFormat.y(widget.locale)
                                .format(widget.calendarController.focusedDay),
                    style: TextStyle(fontSize: 25),
                    textAlign: widget.headerStyle.centerHeaderTitle
                        ? TextAlign.center
                        : TextAlign.start,
                  ),
                ])),
      ),
      CustomIconButton(
        icon: widget.headerStyle.leftChevronIcon,
        onTap: selectPrevious,
        margin: widget.headerStyle.leftChevronMargin,
        padding: widget.headerStyle.leftChevronPadding,
      ),
      CustomIconButton(
        icon: widget.headerStyle.rightChevronIcon,
        onTap: selectNext,
        margin: widget.headerStyle.rightChevronMargin,
        padding: widget.headerStyle.rightChevronPadding,
      ),
    ];

    if (widget.headerStyle.formatButtonVisible &&
        widget.availableCalendarFormats.length > 1) {
      children.insert(2, const SizedBox(width: 8.0));
      children.insert(3, buildFormatButton());
    }

    return Container(
      decoration: widget.headerStyle.decoration,
      margin: widget.headerStyle.headerMargin,
      padding: widget.headerStyle.headerPadding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: children,
      ),
    );
  }
}
