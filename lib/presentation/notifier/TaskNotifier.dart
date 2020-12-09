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
  List<Task> get almostDue => _list == null ? null : List.unmodifiable(_list.where((Task element) => !element.done));
  List<SubjectProgress> get onProgress =>
      _subjectsProgress == null ? null : List.unmodifiable(_subjectsProgress);
  List<Task> get todayClass =>
      _todayClass == null ? null : List.unmodifiable(_todayClass);

  void taskDone(String uuid) {
    Task task=_list.firstWhere((Task element) => element.uuid == uuid);
    task.done=true;
    _updateSubjectProgress();
  }

  void _updateList() {
    _app.list().then((list) {
      _list = list;
      _updateSubjectProgress();
    });
  }

  void _updateSubjectProgress({List<Task> listTask = null}) {
    var list = listTask != null ? listTask : _list;
    _subjectsProgress = _app.subjectProgress(list);
   // _subjectsProgress.sort((a, b) => a.progress.compareTo(b.progress));
    notifyListeners();
  }

  void _updateTodayClass(List<Task> _list) {
    _app.todayClasses().then((list) {
      _todayClass = list;
      notifyListeners();
    });
  }
}
