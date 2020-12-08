import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/stubs/TaskStub.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TaskRepository {
  @override
  Future<Task> find(id) async {
    final list = await Future.delayed(Duration(milliseconds: 100), () {
      List _list;
      Task task =
          new Task(uuid: 'as', title: 'as', deliveryDate: DateTime.now());
      _list.add(task);
      return _list;
    });
    return list.isEmpty ? null : Task.fromJson(list[0]);
  }

  @override
  Future<List<Task>> findAll() async {
    List<Task> _list = [];
    await Future.delayed(Duration(seconds: 3), () {
      List<void>.generate(200, (i) => _list.add(TaskStub.random()));
    });

    if (_list.isEmpty) {
      return <Task>[];
    }

    return _list;
  }

  @override
  Future<void> save(Task category) async {}

  @override
  Future<void> remove(Task category) async {}
}
