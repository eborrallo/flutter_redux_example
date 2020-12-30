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

  static List<SubjectProgress> subjectProgress(List<Task> tasks) {
    List<SubjectProgress> listSubjectProgress = [];

    tasks.forEach((Task element) {
      SubjectProgress newSubjectProgress = new SubjectProgress(element.subject);
      SubjectProgress subjectProgress = listSubjectProgress.firstWhere(
          (SubjectProgress subElement) =>
              subElement.title == element.subject.title,
          orElse: () => null);

      if (subjectProgress != null) {
        subjectProgress.addTask(element);
      } else {
        newSubjectProgress.addTask(element);
        listSubjectProgress.add(newSubjectProgress);
      }
    });

    return listSubjectProgress;
  }
  void sort() {
    list.sort((Subject a, Subject b) => a.title.compareTo(b.title));
  }
}
