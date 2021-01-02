import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/application/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/CalendarNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/ClassNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/TaskNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/class/class.dart';
import 'package:flutter_redux_boilerplate/domain/class/classCollection.dart';
import 'package:flutter_redux_boilerplate/domain/services/Clock.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/TaskRepository.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/stubs/ClassStub.dart';
import 'package:flutter_redux_boilerplate/stubs/SubjectStub.dart';
import 'package:flutter_redux_boilerplate/stubs/TaskStub.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';

class TaskNotifierMock extends Mock implements TaskNotifier {}

class TaskRepositoryMock extends Mock implements TaskRepository {}

class SubjectNotifierMock extends Mock implements SubjectNotifier {}

class ClassNotifierMock extends Mock implements ClassNotifier {}

class CalendarNotifierMock extends Mock implements CalendarNotifier {}

class ClockMock extends Mock implements Clock {}

void main() {
  group('AppNotifier', () {
    AppNotifier sut;

    configureInjection(Environment.test);
    TaskNotifier taskNotifier = new TaskNotifierMock();

    SubjectNotifier subjectNotifier = SubjectNotifierMock();

    ClassNotifier classNotifier = ClassNotifierMock();

    CalendarNotifier calendarNotifier = CalendarNotifierMock();
    Clock clock;
    getIt.registerLazySingleton<Clock>(() => clock);

    setUp(() {
      sut = new AppNotifier(
          taskNotifier, subjectNotifier, classNotifier, calendarNotifier);
    });
    testWidgets('Week Completation', (WidgetTester tester) async {
      List<Task> tasks = [
        TaskStub.create(
            params: {'done': false, 'deliveryDate': DateTime.now().toString()}),
        TaskStub.create(
            params: {'done': true, 'deliveryDate': DateTime.now().toString()})
      ];
      when(taskNotifier.tasksThisWeek).thenReturn(tasks);
      expect(sut.weekCompletation, 50.0);
    });
    testWidgets('Task selected', (WidgetTester tester) async {
      Task task = TaskStub.random();
      sut.selectTask(task);
      expect(sut.taskSelected, task);
    });
    testWidgets('Almost due', (WidgetTester tester) async {
      DateTime today = DateTime.now();
      List<Task> tasks = [
        TaskStub.create(params: {
          'deliveryDate': today.add(Duration(minutes: 10)).toString(),
          'done': false
        }),
        TaskStub.create(params: {
          'deliveryDate': today.add(Duration(minutes: 10)).toString(),
          'done': true
        }),
      ];
      when(taskNotifier.tasks).thenReturn(tasks);

      expect(sut.almostDue, [tasks.first]);
    });
    testWidgets('Today Classes', (WidgetTester tester) async {
      initializeDateFormatting('es-ES');

      DateTime today = DateTime.now();
      List<Class> listClass = [];
      List<TodayClass> listExpected = [];
      List.generate(2, (index) {
        Subject subject = SubjectStub.random();
        List<Task> tasksClass = [
          TaskStub.create(params: {
            'deliveryDate': today.toString(),
            'done': false,
            'subject': subject
          }),
          TaskStub.create(params: {
            'deliveryDate': today.toString(),
            'done': true,
            'subject': subject
          }),
        ];

        Class cls = ClassStub.create(params: {'subject': subject.toJson()});

        tasksClass.forEach((element) {
          cls.addTask(element);
        });
        listExpected.add(new TodayClass(
            title: cls.subject.title,
            location: cls.location,
            timeIn: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
                .format(cls.startTime),
            timeOut: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
                .format(cls.startTime.add(cls.duration)),
            message: Intl.plural(
              1,
              one: 'Falta 1 tarea por hacer',
              other: 'Faltan 2 tareas por hacer',
            )));
        listClass.add(cls);
      });
      ClassCollection classCollection = ClassCollection(list: listClass);

      when(classNotifier.todayClasses)
          .thenReturn(classCollection.todayClasses(listClass));

      expect(sut.todayClasses.toString(), listExpected.toString());
    });

    testWidgets('AddTask', (WidgetTester tester) async {
      TaskRepository taskRepository = new TaskRepositoryMock();
      DateTime date = DateTime.now();
      Task task = TaskStub.create(params: {
        'done': false,
        'deliveryDate': date.add(Duration(minutes: 5)).toString()
      });
      when(classNotifier.addTask(task)).thenReturn(null);
      var repoTasks = [
        TaskStub.create(params: {
          'done': true,
          'deliveryDate': date.add(Duration(minutes: 3)).toString()
        }),
        TaskStub.create(params: {
          'done': false,
          'deliveryDate': date.add(Duration(minutes: 4)).toString()
        })
      ];
      when(taskRepository.findAll()).thenAnswer((_) => Future.value(repoTasks));
      clock = new ClockMock();
      when(clock.now()).thenReturn(date);

      TaskNotifier taskNotifier = new TaskNotifier(taskRepository);
      sut = new AppNotifier(
          taskNotifier, subjectNotifier, classNotifier, calendarNotifier);
      await untilCalled(taskRepository.findAll());
      sut.addTask(task);
      expect(sut.almostDue.indexOf(task), isNot(-1));
    });
  });
}
