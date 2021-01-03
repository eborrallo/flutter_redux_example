import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayExtension on TimeOfDay {
  Duration difference(TimeOfDay other) {
    int from = this.toDouble(this);
    int to = this.toDouble(other);

    return Duration(minutes: to - from);
  }

  DateTime toDateTime() {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, this.hour, this.minute);
    return dt;
  }

  String formatTimeOfDay() {
    final format = DateFormat.jm();
    return format.format(this.toDateTime());
  }

  int toDouble(TimeOfDay myTime) => myTime.hour * 60 + myTime.minute;
}
