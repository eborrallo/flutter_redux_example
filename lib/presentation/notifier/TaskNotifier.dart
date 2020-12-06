import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/TaskService.dart';
import 'package:flutter_redux_boilerplate/application/dto/SubjectProgres.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:injectable/injectable.dart';

@injectable
class TaskNotifier extends ChangeNotifier {
  bool isLoading = false;
  TaskService _app;

  TaskNotifier(this._app);

  List<Task> _list;
  List<SubjectProgress> _subjectsProgress;
  List<Task> get list => _list == null ? null : List.unmodifiable(_list);

  void _updateList() {
    _app.list().then((list) {
      _list = list;
      _updateSubjectProgress(_list);
    });
  }

  void _updateSubjectProgress(List<Task> _list) {
    _app.subjectProgress(_list).then((list) {
      _subjectsProgress = list;
      notifyListeners();
    });
  }
}
