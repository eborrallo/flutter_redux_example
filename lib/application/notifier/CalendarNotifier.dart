import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:injectable/injectable.dart';

@injectable
class CalendarNotifier extends ChangeNotifier {

  Map<DateTime, List<Task>> taskByDay(List<Task> tasks) {
    Map<DateTime, List<Task>> _calendarEvents = Map();
    tasks == null
        ? []
        : tasks.forEach((Task _task) {
            DateTime _datetime = new DateTime(_task.deliveryDate.year,
                _task.deliveryDate.month, _task.deliveryDate.day);
            _calendarEvents.putIfAbsent(_datetime, () => []).add(_task);

            // _calendarEvents[_datetime].add(_task);
          });
    return _calendarEvents;
  }
}
