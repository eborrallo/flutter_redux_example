import 'package:flutter/material.dart';


@immutable
class TodayClass {
  final String title;
  final String room;
  final String timeIn;
  final String timeOut;
  final bool incompletedTask;

  TodayClass(
      this.title, this.room, this.timeIn, this.timeOut, this.incompletedTask);
}
