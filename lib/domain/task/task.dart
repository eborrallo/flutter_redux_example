import 'dart:convert';

import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(nullable: true)
class Task {
  final String uuid;
  final String title;
  final Subject subject;
  final DateTime deliveryDate;
  bool done;

  Task({
    this.uuid,
    this.title,
    this.subject,
    this.deliveryDate,
    this.done,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
