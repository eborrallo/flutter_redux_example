import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/ClassService.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/class/class.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClassNotifier extends ChangeNotifier {
  ClassService _classService;
  List<TodayClass> _todayClass;
  List<Class> _classes;

  ClassNotifier(this._classService) {
    _updateTodayClass();
  }
  void toggleTask(String uuid) {
    List<Class> listClasses = _classes.map((Class _cls) {
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
    _todayClass = _classService.todayClasses(classes);
    notifyListeners();
  }

  void _updateTodayClass() {
    _classService.list().then((value) {
      _classes = value;
      _update(value);
    });
  }
}
