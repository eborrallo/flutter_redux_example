import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/domain/task/taskCollection.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/TaskRepository.dart';
import 'package:injectable/injectable.dart';

@injectable
class TaskNotifier extends ChangeNotifier {
  final TaskRepository taskRepository;
  bool _showOld = false;

  TaskNotifier(this.taskRepository) {
    _updateList();
  }

  TaskCollection _taskCollection;
  bool get showOld => this._showOld;

  List<Task> get allTasks => _taskCollection?.list == null
      ? null
      : List.unmodifiable(_taskCollection.list);

  List<Task> get tasks => _taskCollection == null
      ? null
      : List.unmodifiable(_taskCollection.nexts());

  List<Task> get tasksThisWeek => _taskCollection.list == null
      ? null
      : List.unmodifiable(_taskCollection.byWeek());

  List<Task> get today => _taskCollection.list == null
      ? null
      : List.unmodifiable(_taskCollection.list
          .where((element) =>
              element.deliveryDate.day == DateTime.now().day &&
              element.deliveryDate.month == DateTime.now().month &&
              element.deliveryDate.year == DateTime.now().year)
          .toList());
  List<Task> get oldest => _taskCollection.list == null
      ? null
      : List.unmodifiable(_taskCollection.list
          .where((element) =>
              element.deliveryDate.day < DateTime.now().day &&
              element.deliveryDate.month <= DateTime.now().month &&
              element.deliveryDate.year <= DateTime.now().year)
          .toList());
  List<Task> get tomorrow => _taskCollection.list == null
      ? null
      : List.unmodifiable(_taskCollection.list
          .where((element) =>
              element.deliveryDate.day ==
                  DateTime.now().add(Duration(days: 1)).day &&
              element.deliveryDate.month ==
                  DateTime.now().add(Duration(days: 1)).month &&
              element.deliveryDate.year ==
                  DateTime.now().add(Duration(days: 1)).year)
          .toList());
  List<Task> get upComing => _taskCollection.list == null
      ? null
      : List.unmodifiable(_taskCollection.list
          .where((element) =>
              element.deliveryDate.day >
                  DateTime.now().add(Duration(days: 1)).day &&
              element.deliveryDate.month >=
                  DateTime.now().add(Duration(days: 1)).month &&
              element.deliveryDate.year >=
                  DateTime.now().add(Duration(days: 1)).year)
          .toList());

  void addTask(Task task) {
    _taskCollection.add(task);

    notifyListeners();
  }

  void toggleShowOld() {
    this._showOld = !this._showOld;
    notifyListeners();
  }

  void toggleTask(String uuid) {
    Task task =
        _taskCollection.list.firstWhere((Task element) => element.uuid == uuid);
    task.done = !task.done;

    //     List<Task> _list = _taskCollection.list.map((Task element) {
    //   if (element.uuid == uuid) {
    //     element.done = !element.done;
    //     print(element);
    //   }
    //   return element;
    // }).toList();

    // _taskCollection = TaskCollection(list: _list);
    notifyListeners();
  }

  void _updateList() {
    taskRepository.findAll().then((list) {
      _taskCollection = TaskCollection(list: list);
      notifyListeners();
    });
  }
}
