import 'package:flutter_redux_boilerplate/application/notifier/TaskNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/services/Clock.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/TaskRepository.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/stubs/SubjectStub.dart';
import 'package:flutter_redux_boilerplate/stubs/TaskStub.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class TaskRepositoryMock extends Mock implements TaskRepository {}

class ClockMock extends Mock implements Clock {}

void main() {
  group('TaskNotifier', () {
    TaskNotifier sut;

    List<Task> tasks;
    TaskRepository taskRepository;
    configureInjection(Environment.test);
    DateTime date = DateTime(2020, 12, 31, 5, 30);

    getIt.registerLazySingleton<Clock>(() {
      Clock clock = new ClockMock();
      when(clock.now()).thenReturn(date);
      return clock;
    });
    String uuidTask = Uuid().v4();

    setUp(() {
      taskRepository = new TaskRepositoryMock();

      tasks = [
        TaskStub.create(params: {
          'done': true,
          'deliveryDate': date.add(Duration(days: 1)).toString()
        }),
        TaskStub.create(params: {
          'uuid': uuidTask,
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

      sut = new TaskNotifier(taskRepository);
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
      expect(sut.tasksThisWeek.toString(),
          [tasks[0], tasks[1], tasks[3]].toString());
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
    testWidgets('Add task', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      Task task = TaskStub.random();
      sut.addTask(task);
      var indexTask = sut.allTasks.indexOf(task);
      expect(indexTask, isNot(-1));
      expect(sut.allTasks[indexTask], task);
    });
    testWidgets('Search', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      Task task = TaskStub.create(params: {
        'title': 'testSearch',
        'deliveryDate': date.subtract(Duration(minutes: 1)).toString()
      });
      sut.addTask(task);
      sut.searchBy('testSearch');
      expect(sut.today, [task]);
      sut.stopSearch();
      expect(sut.today, isNot([task]));
    });
    testWidgets('Toggle show old', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      expect(sut.showOld, false);
      sut.toggleShowOld();
      expect(sut.showOld, true);
    });
    testWidgets('Update task whit Subject', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      Subject subject = SubjectStub.create(params: {'title': 'subjectTitle'});
      Task task = TaskStub.create(params: {
        'title': 'testSearch',
        'subject': subject,
        'deliveryDate': date.subtract(Duration(minutes: 1)).toString()
      });
      sut.addTask(task);
      Subject newSubject = SubjectStub.create(params: {'uuid': subject.uuid});
      sut.updateTasksWithSubject(newSubject);
      sut.searchBy('testSearch');
      var taskWithsubjectChanged = sut.today.first;
      expect(task.subject.title, isNot(newSubject.title));

      expect(taskWithsubjectChanged.subject.title, newSubject.title);
    });
    testWidgets('Toggle task', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      sut.toggleTask(uuidTask);
      expect(tasks[1].done, true);
      sut.toggleTask(uuidTask);
      expect(tasks[1].done, false);
    });
    testWidgets('Delete by', (WidgetTester tester) async {
      await untilCalled(taskRepository.findAll());
      sut.deleteBy((Task task) => task.uuid == uuidTask);
      expect(() => tasks.firstWhere((element) => element.uuid == uuidTask),
          throwsA(isA<StateError>()));
    });
  });
}
