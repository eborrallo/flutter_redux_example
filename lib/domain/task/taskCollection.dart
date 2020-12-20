import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:flutter_redux_boilerplate/domain/extensions/week_of_day.dart';

part 'taskCollection.g.dart';

@JsonSerializable(nullable: true)
class TaskCollection {
  final List<Task> list;

  TaskCollection({this.list});

  factory TaskCollection.fromJson(Map<String, dynamic> json) =>
      _$TaskCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$TaskCollectionToJson(this);

  List<Task> nexts() => list
      .where((Task _task) =>
          _task.deliveryDate.millisecondsSinceEpoch >
          DateTime.now().millisecondsSinceEpoch)
      .toList();
  List<Task> byWeek() => list
      .where((Task _task) =>
          _task.deliveryDate.weekOfYear == DateTime.now().weekOfYear)
      .toList();
  void add(Task task) {
    list.add(task);
    list.sort((Task a, Task b) => a.deliveryDate.compareTo(b.deliveryDate));
  }

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
