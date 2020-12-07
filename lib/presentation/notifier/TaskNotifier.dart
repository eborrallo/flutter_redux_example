import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/TaskService.dart';
import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:injectable/injectable.dart';

@injectable
class TaskNotifier extends ChangeNotifier {
  bool isLoading = false;
  TaskService _app;

  TaskNotifier(this._app) {
    _updateList();
  }

  List<Task> _list;
  List<SubjectProgress> _subjectsProgress;
  List<TodayClass> _todayClass;
  List<Task> get almostDue => _list == null ? null : List.unmodifiable(_list);
  List<Task> get onProgress =>
      _subjectsProgress == null ? null : List.unmodifiable(_subjectsProgress);
  List<Task> get todayClass =>
      _todayClass == null ? null : List.unmodifiable(_todayClass);

  void _updateList() {
    _app.list().then((list) {
      _list = list;
      tesss().then((value) => notifyListeners());
      notifyListeners();
      // _updateSubjectProgress(_list);
    });
  }

  Future tesss() {
    return Future.delayed(Duration(seconds: 3), () {
      _list.removeLast();
    });
  }

  void _updateSubjectProgress(List<Task> _list) {
    _app.subjectProgress(_list).then((list) {
      _subjectsProgress = list;
      notifyListeners();
    });
  }

  void _updateTodayClass(List<Task> _list) {
    _app.todayClasses().then((list) {
      _todayClass = list;
      notifyListeners();
    });
  }
}
