import 'package:flutter/material.dart';


@immutable
class TodayClass {
  final String title;
  final String location;
  final String timeIn;
  final String timeOut;
  final String message;

  TodayClass(
     { this.title, this.location, this.timeIn, this.timeOut, this.message});

     
}
