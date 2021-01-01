import 'dart:convert';

import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subjectCollection.g.dart';

@JsonSerializable(nullable: true)
class SubjectCollection {
  final List<Subject> list;

  SubjectCollection({this.list});

  factory SubjectCollection.fromJson(Map<String, dynamic> json) =>
      _$SubjectCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectCollectionToJson(this);

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }


  void sort() {
    list.sort((Subject a, Subject b) => a.title.compareTo(b.title));
  }
}
