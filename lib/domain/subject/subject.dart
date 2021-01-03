import 'dart:convert';

import 'package:flutter_redux_boilerplate/domain/class/class.dart';
import 'package:flutter_redux_boilerplate/domain/lecturer/lecturer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subject.g.dart';

@JsonSerializable(nullable: true, anyMap: true)
class Subject {
  final String uuid;
  final String title;
  final String description;
  final List<Lecturer> lecturers;
  final List<Class> classes;
  final String color;

  Subject(this.classes,
      {this.description, this.color, this.uuid, this.title, this.lecturers});

  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson({
        'uuid': json['uuid'],
        'title': json['title'],
        'description': json['description'],
        'lecturers': json['lecturers'],
        'classes': json['classes'].map((e) {
          if (!(e is Map)) {
            return e.toJson();
          }
          return e;
        }).toList(),
        'color': json['color'],
      });

  Map<String, dynamic> toJson() => _$SubjectToJson(this);

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
