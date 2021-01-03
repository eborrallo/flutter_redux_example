import 'dart:convert';

import 'package:flutter_redux_boilerplate/domain/lecturer/lecturer.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'class.g.dart';

@JsonSerializable(nullable: true)
class Class {
  final String uuid;
  final List<Task> tasks;
  final Subject subject;
  final Duration duration;
  final DateTime startTime;
  final String location;
  final int dayOfWeek;

  Class(
      {this.uuid,
      this.tasks,
      this.subject,
      this.duration,
      this.startTime,
      this.location,
      this.dayOfWeek,
      });

  addTask(Task task) {
    this.tasks.add(task);
  }

  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);
  Map<String, dynamic> toJson() => _$ClassToJson(this);

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
