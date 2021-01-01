import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/domain/services/Clock.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:flutter_redux_boilerplate/domain/extensions/date_time_extension.dart';

part 'taskCollection.g.dart';

@JsonSerializable(nullable: true)
class TaskCollection {
  final List<Task> list;
  Clock _clock;
  TaskCollection({this.list}) {
    _clock = getIt<Clock>();
  }

  factory TaskCollection.fromJson(Map<String, dynamic> json) =>
      _$TaskCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$TaskCollectionToJson(this);

  List<Task> nexts() => list
      .where((Task _task) =>
          _task.deliveryDate.millisecondsSinceEpoch >
          this._clock.now().millisecondsSinceEpoch)
      .toList();
  List<Task> thisWeek() => list
      .where((Task _task) =>
          _task.deliveryDate.weekOfYear == _clock.now().weekOfYear)
      .toList();
  void add(Task task) {
    list.add(task);
    _sort();
  }

  void _sort() {
    list.sort((Task a, Task b) => a.deliveryDate.compareTo(b.deliveryDate));
  }

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }

  List search(String value) {
    return list
        .where((Task element) =>
            element.title.contains(value) ||
            element.description.contains(value) ||
            element.subject.title.contains(value))
        .toList();
  }

  void updateWithSubject(Subject subject) {
    var jsonSubject = subject.toJson();
    list.forEach((Task element) {
      if (element.subject.uuid == subject.uuid) {
        var jsonTask = element.toJson();
        jsonTask['subject'] = jsonSubject;
        list.add(Task.fromJson(jsonTask));
        list.remove(element);
      }
    });
    _sort();
  }

   List<SubjectProgress> subjectProgress() {
    List<SubjectProgress> listSubjectProgress = [];

    list.forEach((Task element) {
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

}
