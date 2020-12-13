import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/ClassService.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClassNotifier extends ChangeNotifier {
  ClassService _classService;
  List<TodayClass> _todayClass;

  ClassNotifier(this._classService) {
    _updateTodayClass();
  }

  List<TodayClass> get todayClasses =>
      _todayClass == null ? null : List.unmodifiable(_todayClass);

  void _updateTodayClass() {
    _classService.todayClasses().then((list) {
      _todayClass = list;
      notifyListeners();
    });
  }
}
