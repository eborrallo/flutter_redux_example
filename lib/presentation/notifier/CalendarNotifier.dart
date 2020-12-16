import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CalendarNotifier extends ChangeNotifier {
  DateTime selectedDay;

  CalendarNotifier() {
    this.selectedDay = DateTime.now();
  }

  void selecteDay(DateTime _day) {
    this.selectedDay = _day;
    notifyListeners();
  }

}
