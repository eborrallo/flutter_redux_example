import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/table_calendar/calendar.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/table_calendar/widgets/custom_icon_button.dart';
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
    return super.build(context);
  }

  @override
  Widget buildHeader() {
    final children = [
      Expanded(
        child: GestureDetector(
          onTap: onHeaderTapped,
          onLongPress: onHeaderLongPressed,
          child: Text(
            widget.headerStyle.titleTextBuilder != null
                ? widget.headerStyle.titleTextBuilder(
                    widget.calendarController.focusedDay, widget.locale)
                : DateFormat.yMMMM(widget.locale)
                    .format(widget.calendarController.focusedDay),
            style: widget.headerStyle.titleTextStyle,
            textAlign: widget.headerStyle.centerHeaderTitle
                ? TextAlign.center
                : TextAlign.start,
          ),
        ),
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
