import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'taskCollection.g.dart';

@JsonSerializable(nullable: true)
class TaskCollection {
  final List<Task> list;

  TaskCollection({this.list});
  
  factory TaskCollection.fromJson(Map<String, dynamic> json) =>
      _$TaskCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$TaskCollectionToJson(this);

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
