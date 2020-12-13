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

  Future<List<TodayClass>> todayClasses() async {
    List<TodayClass> listTodayClass = [];

    List<Class> classes = await repository.findAll();
    classes.forEach((Class element) {
      listTodayClass.add(new TodayClass(
          title: element.subject.title,
          location: element.location,
          timeIn: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
              .format(element.startTime),
          timeOut: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
              .format(element.startTime.add(element.duration)),
          message: 'caca'));
    });

    return listTodayClass;
  }
}
