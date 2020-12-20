import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/TaskService.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_redux_boilerplate/domain/extensions/week_of_day.dart';

@injectable
class TaskNotifier extends ChangeNotifier {
  TaskService _app;

  TaskNotifier(this._app) {
    _updateList();
  }

  List<Task> _list;
  List<Task> get allTasks => _list == null ? null : List.unmodifiable(_list);

  List<Task> get tasks => _list == null
      ? null
      : List.unmodifiable(_list.where((Task _task) =>
          _task.deliveryDate.millisecondsSinceEpoch > DateTime.now().millisecondsSinceEpoch));
  List<Task> get tasksThisWeek => _list == null
      ? null
      : List.unmodifiable(_list
          .where((Task _task) =>
              _task.deliveryDate.weekOfYear == DateTime.now().weekOfYear)
          .toList());

  void toggleTask(String uuid) {
    Task task = _list.firstWhere((Task element) => element.uuid == uuid);
    task.done = !task.done;
    notifyListeners();
  }

  void _updateList() {
    _app.list().then((list) {
      _list = list;
      notifyListeners();
    });
  }
}
