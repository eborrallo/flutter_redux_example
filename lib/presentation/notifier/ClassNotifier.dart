import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/ClassService.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClassNotifier extends ChangeNotifier {
  ClassService _classService;

  ClassNotifier(this._classService) {
    _updateTodayClass();
  }

  List<TodayClass> _todayClass;
  List<TodayClass> get todayClasses => _todayClass == null ? null : _todayClass;

  void _updateTodayClass() {
    _classService.todayClasses().then((list) {
      _todayClass = list;
      notifyListeners();
    });
  }
}
