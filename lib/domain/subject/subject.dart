import 'dart:convert';

import 'package:flutter_redux_boilerplate/domain/lecturer/lecturer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subject.g.dart';

@JsonSerializable(nullable: false)
class Subject {
  final String uuid;
  final String title;
  final List<Lecturer> lecturers;

  Subject({this.uuid, this.title,this.lecturers});

  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
  
@override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
