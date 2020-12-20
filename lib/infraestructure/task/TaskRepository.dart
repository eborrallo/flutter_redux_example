import 'dart:convert';

import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/domain/task/taskCollection.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/stubs/ApiStub.dart';
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
    await Future.delayed(Duration(seconds: 1), () {
      _list = getIt<ApiStub>().tasks;
      _list.sort((Task a, Task b) => a.deliveryDate.compareTo(b.deliveryDate));

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
