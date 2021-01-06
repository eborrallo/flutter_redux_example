import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/domain/task/taskCollection.dart';

@immutable
class TodayClass {
  final String title;
  final String location;
  final String timeIn;
  final String timeOut;
  final String message;
  final String description;
  final List<Task> tasks;

  TodayClass(
      {this.title,
      this.location,
      this.timeIn,
      this.timeOut,
      this.message,
      this.description,
      this.tasks});
}
