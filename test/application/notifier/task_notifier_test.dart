import 'package:flutter_redux_boilerplate/application/notifier/TaskNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/services/Clock.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/TaskRepository.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/stubs/TaskStub.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

class TaskRepositoryMock extends Mock implements TaskRepository {}

class ClockMock extends Mock implements Clock {}

void main() {
  group('TaskNotifier', () {
    TaskNotifier sut;

    Clock clock;
    List<Task> tasks;
    TaskRepository taskRepository;
    configureInjection(Environment.test);
    getIt.registerLazySingleton<Clock>(() => clock);

    setUp(() {
      taskRepository = new TaskRepositoryMock();
      clock = new ClockMock();
      DateTime date = DateTime(2020, 12, 31, 5, 30);
      tasks = [
        TaskStub.create(params: {
          'done': true,
          'deliveryDate': date.add(Duration(days: 1)).toString()
        }),
        TaskStub.create(params: {
          'done': false,
          'deliveryDate': date.subtract(Duration(minutes: 1)).toString()
        }),
        TaskStub.create(params: {
          'done': true,
          'deliveryDate': date.subtract(Duration(days: 10)).toString()
        }),
        TaskStub.create(params: {
          'done': false,
          'deliveryDate': date.add(Duration(days: 2)).toString()
        })
      ];
      when(taskRepository.findAll()).thenAnswer((_) => Future.value(tasks));
      when(clock.now()).thenReturn(date);

      sut = new TaskNotifier(taskRepository, clock);
    });
    testWidgets('All tasks', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.allTasks, tasks);
    });
    testWidgets('Tasks nexts', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.tasks.toString(), [tasks.first, tasks[3]].toString());
    });
    testWidgets('Tasks this week', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.tasksThisWeek.toString(), [tasks[0], tasks[1],tasks[3]].toString());
    });
    testWidgets('Today', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.today.toString(), [tasks[1]].toString());
    });
    testWidgets('Oldest', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.oldest.toString(), [tasks[2]].toString());
    });
    testWidgets('Tomorrow', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.tomorrow.toString(), [tasks[0]].toString());
    });
    testWidgets('Up coming', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.upComing.toString(), [tasks[3]].toString());
    });
  });
}
