import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/class/class.dart';
import 'package:flutter_redux_boilerplate/domain/class/classCollection.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/ClassRepository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClassNotifier extends ChangeNotifier {
  List<TodayClass> _todayClass;
  ClassCollection _classes;
  final ClassRepository repository;

  ClassNotifier(this.repository) {
    _updateTodayClass();
  }
  void toggleTask(String uuid) {
    List<Class> listClasses = _classes.list.map((Class _cls) {
      Task task = _cls.tasks
          .firstWhere((element) => element.uuid == uuid, orElse: () => null);
      if (task != null) {
        task.done = !task.done;
      }
      return _cls;
    }).toList();

    _update(listClasses);
  }

  List<TodayClass> get todayClasses =>
      _todayClass == null ? null : List.unmodifiable(_todayClass);

  void _update(List<Class> classes) {
    _todayClass = _classes.todayClasses(classes);
    notifyListeners();
  }

  void _updateTodayClass() {
    repository.findAll().then((value) {
      _classes = ClassCollection(list: value);
      _update(value);
    });
  }
}
