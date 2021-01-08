import 'dart:convert';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/class/class.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/taskCollection.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'classCollection.g.dart';

@JsonSerializable(nullable: true)
class ClassCollection {
  final List<Class> list;
  ClassCollection({this.list});

  factory ClassCollection.fromJson(Map<String, dynamic> json) =>
      _$ClassCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$ClassCollectionToJson(this);

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }

  TodayClass _todayClass(Subject subject, Class element) {
    int pendingTasksToday = subject.tasks
        ?.where((elementTasks) =>
            !elementTasks.done &&
            elementTasks.deliveryDate.day == DateTime.now().day &&
            elementTasks.deliveryDate.month == DateTime.now().month &&
            elementTasks.deliveryDate.year == DateTime.now().year)
        ?.length;
    TaskCollection taskCollection = TaskCollection(list: subject.tasks);
    taskCollection.sort(asc: false);
    return new TodayClass(
        title: subject.title,
        location: element.location,
        timeIn: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
            .format(element.startTime),
        timeOut: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
            .format(element.endTime),
        description: subject.description,
        tasks: taskCollection.list,
        dayOfWeek: element.dayOfWeek,
        message: pendingTasksToday != null && pendingTasksToday > 0
            ? Intl.plural(
                pendingTasksToday,
                one: 'Falta ' +
                    pendingTasksToday.toString() +
                    ' tarea por hacer',
                other: 'Tareas pendientes del total ' +
                    pendingTasksToday.toString(),
              )
            : null);
  }

  List<TodayClass> todayClasses(Subject subject) {
    List<TodayClass> listTodayClass = [];

    list.forEach((Class element) {
      if (element.dayOfWeek == DateTime.now().weekday % 7) {
        listTodayClass.add(_todayClass(subject, element));
      }
    });

    return listTodayClass;
  }

  List<TodayClass> classes(Subject subject) {
    List<TodayClass> listTodayClass = [];

    list.forEach((Class element) {
      listTodayClass.add(_todayClass(subject, element));
    });

    return listTodayClass;
  }
}
