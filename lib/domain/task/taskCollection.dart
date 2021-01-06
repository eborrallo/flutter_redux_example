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
  Clock _clock = getIt<Clock>();
  TaskCollection({this.list});

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
    sort();
  }

  Map<DateTime, List<Task>> taskByDay() {
    Map<DateTime, List<Task>> _calendarEvents = Map();
    list == null
        ? []
        : list.forEach((Task _task) {
            DateTime _datetime = new DateTime(_task.deliveryDate.year,
                _task.deliveryDate.month, _task.deliveryDate.day);
            _calendarEvents.putIfAbsent(_datetime, () => []).add(_task);

            // _calendarEvents[_datetime].add(_task);
          });
    return _calendarEvents;
  }

  void sort({bool asc = true}) {
    list.sort((Task a, Task b) {
      if (asc) {
        return a.deliveryDate.compareTo(b.deliveryDate);
      }
      return b.deliveryDate.compareTo(a.deliveryDate);
    });
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
    sort();
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

  void toggleTask(String uuid) {
    Task task =
        list.firstWhere((Task element) => element.uuid == uuid, orElse: null);
    task.done = !task.done;
  }
}
