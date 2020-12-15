import 'dart:async';

import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/class/class.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/ClassRepository.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class ClassService {
  final ClassRepository repository;
  ClassService(this.repository);

  Future<List<Class>> list() {
    return repository.findAll();
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
