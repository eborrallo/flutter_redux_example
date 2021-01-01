import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/application/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/CalendarNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/ClassNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/TaskNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/TaskRepository.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/stubs/TaskStub.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

class TaskRepositoryMock extends Mock implements TaskRepository {}

void main() {
    TaskNotifier sut;
    List<Task> tasks;
    TaskRepository taskRepository;
    configureInjection(Environment.test);

    setUp(() {
      taskRepository = new TaskRepositoryMock();
      tasks = [
        TaskStub.create(params: {
          'done': true,
          'deliveryDate': DateTime.now().add(Duration(days: 1)).toString()
        }),
        TaskStub.create(params: {
          'done': false,
          'deliveryDate':
              DateTime.now().subtract(Duration(minutes: 1)).toString()
        }),
        TaskStub.create(params: {
          'done': true,
          'deliveryDate': DateTime.now().subtract(Duration(days: 10)).toString()
        }),
      ];
      when(taskRepository.findAll()).thenAnswer((_) => Future.value(tasks));
      sut = new TaskNotifier(taskRepository);
    });
    testWidgets('All tasks', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.allTasks, tasks);
    });
    testWidgets('Tasks', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.tasks.toString(), [tasks.first].toString());
    });
    testWidgets('Tasks this week', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.tasksThisWeek.toString(), [tasks[0],tasks[1]].toString());
    });
    testWidgets('Today', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.today.toString(), [
        tasks[1]].toString());
    });
    testWidgets('Oldest', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.oldest.toString(), [tasks[2]].toString());
    });
    testWidgets('Tomorrow', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.tomorrow.toString(), [tasks[0]].toString());
    });
}
