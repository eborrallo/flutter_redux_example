import 'dart:convert';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'class.g.dart';

@JsonSerializable(nullable: true)
class Class {
  final String uuid;
 // final Subject subject;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final int dayOfWeek;

  Class(
      {this.uuid,
//      this.subject,
      this.startTime,
      this.endTime,
      this.location,
      this.dayOfWeek,
      });



  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);
  Map<String, dynamic> toJson() => _$ClassToJson(this);

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
