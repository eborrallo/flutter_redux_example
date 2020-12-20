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
      listTodayClass.add(new TodayClass(
          title: element.subject.title,
          location: element.location,
          timeIn: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
              .format(element.startTime),
          timeOut: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
              .format(element.startTime.add(element.duration)),
          message: element.tasks
                      .where((elementTasks) => !elementTasks.done)
                      .length >
                  0
              ? Intl.plural(
                  element.tasks.length,
                  one: 'Falta ' +
                      element.tasks.where((t) => !t.done).length.toString() +
                      ' tarea por hacer',
                  other: 'Faltan ' +
                      element.tasks.where((t) => !t.done).length.toString() +
                      ' tareas por hacer',
                )
              : null));
    });

    return listTodayClass;
  }
}
