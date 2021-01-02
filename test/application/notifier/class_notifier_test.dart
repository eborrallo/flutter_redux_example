import 'package:flutter_redux_boilerplate/application/dto/TodayClass.dart';
import 'package:flutter_redux_boilerplate/application/notifier/ClassNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/class/class.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/ClassRepository.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/SubjectRepository.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/stubs/ClassStub.dart';
import 'package:flutter_redux_boilerplate/stubs/SubjectStub.dart';
import 'package:flutter_redux_boilerplate/stubs/TaskStub.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class ClassRepositoryMock extends Mock implements ClassRepository {}

void main() {
  group('ClassNotifier', () {
    ClassNotifier sut;
    String uuid = Uuid().v4();
    Subject subject = SubjectStub.random();
    List<Class> list = [
      ClassStub.create(params: {'uuid': uuid, 'subject': subject.toJson()}),
    ];

    ClassRepository repository = new ClassRepositoryMock();
    configureInjection(Environment.test);

    setUp(() {
      when(repository.findAll()).thenAnswer((_) => Future.value(list));
      sut = new ClassNotifier(repository);
      initializeDateFormatting('es-ES');
    });
    testWidgets('Today Classes', (WidgetTester tester) async {
      await untilCalled(repository.findAll());
      TodayClass tc = TodayClass(
          title: list[0].subject.title,
          location: list[0].location,
          timeIn: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
              .format(list[0].startTime),
          timeOut: DateFormat(DateFormat.HOUR24_MINUTE, 'es_ES')
              .format(list[0].startTime.add(list[0].duration)),
          message: null);
      expect(sut.todayClasses.toString(), [tc].toString());
    });
    testWidgets('Add task', (WidgetTester tester) async {
      await untilCalled(repository.findAll());
      String _uuid = Uuid().v4();
      Task task = TaskStub.create(params: {'uuid': _uuid, 'subject': subject});
      sut.addTask(task);
    });
  });
}
