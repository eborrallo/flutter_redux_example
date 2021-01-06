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

  List<TodayClass> todayClasses(Subject subject) {
    List<TodayClass> listTodayClass = [];

    list.forEach((Class element) {
      if (element.dayOfWeek == DateTime.now().weekday % 7) {
        int pendingTasksToday = subject.tasks
            ?.where((elementTasks) =>
                !elementTasks.done &&
                elementTasks.deliveryDate.day == DateTime.now().day &&
                elementTasks.deliveryDate.month == DateTime.now().month &&
                elementTasks.deliveryDate.year == DateTime.now().year)
            ?.length;
        TaskCollection taskCollection = TaskCollection(list: subject.tasks);
        taskCollection.sort(asc: false);
        listTodayClass.add(new TodayClass(
            title: subject.title,
            location: element.location,
            timeIn: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
                .format(element.startTime),
            timeOut: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
                .format(element.endTime),
            description: subject.description,
            tasks: taskCollection.list,
            message: pendingTasksToday != null && pendingTasksToday > 0
                ? Intl.plural(
                    pendingTasksToday,
                    one: 'Falta ' +
                        pendingTasksToday.toString() +
                        ' tarea por hacer',
                    other: 'Tareas pendientes del total ' +
                        pendingTasksToday.toString(),
                  )
                : null));
      }
    });

    return listTodayClass;
  }
}
