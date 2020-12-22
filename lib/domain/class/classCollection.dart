import 'dart:convert';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/class/class.dart';
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

  List<TodayClass> todayClasses(List<Class> classes) {
    List<TodayClass> listTodayClass = [];

    classes.forEach((Class element) {
      int doneTasksToday = element.tasks
          .where((elementTasks) =>
              !elementTasks.done &&
              elementTasks.deliveryDate.day == DateTime.now().day &&
              elementTasks.deliveryDate.month == DateTime.now().month &&
              elementTasks.deliveryDate.year == DateTime.now().year)
          .length;
      listTodayClass.add(new TodayClass(
          title: element.subject.title,
          location: element.location,
          timeIn: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
              .format(element.startTime),
          timeOut: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
              .format(element.startTime.add(element.duration)),
          message: doneTasksToday > 0
              ? Intl.plural(
                  element.tasks.length,
                  one:
                      'Falta ' + doneTasksToday.toString() + ' tarea por hacer',
                  other: 'Faltan ' +
                      doneTasksToday.toString() +
                      ' tareas por hacer',
                )
              : null));
    });

    return listTodayClass;
  }
}
