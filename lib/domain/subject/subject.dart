import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/lecturer/lecturer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subject.g.dart';

@JsonSerializable(nullable: true)
class Subject {
  final String uuid;
  final String title;
  final String description;
  final List<Lecturer> lecturers;
  final String color;

  Subject({this.description, this.color, this.uuid, this.title,this.lecturers});

  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
  
@override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
