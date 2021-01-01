import 'package:flutter_redux_boilerplate/application/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/application/notifier/TaskNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/services/Clock.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/SubjectRepository.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/TaskRepository.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/stubs/SubjectStub.dart';
import 'package:flutter_redux_boilerplate/stubs/TaskStub.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class SubjectRepositoryMock extends Mock implements SubjectRepository {}

void main() {
  group('SubjectNotifier', () {
    SubjectNotifier sut;
    String uuidTask = Uuid().v4();

    List<Subject> list = [
      SubjectStub.random(),
      SubjectStub.create(params: {
        'uuid': uuidTask,
      }),
    ];
    
    SubjectRepository repository = new SubjectRepositoryMock();
    configureInjection(Environment.test);

    setUp(() {
      when(repository.findAll()).thenAnswer((_) => Future.value(list));
      sut = new SubjectNotifier(repository);
    });
    testWidgets('All subjects', (WidgetTester tester) async {
      await untilCalled(repository.findAll());
      expect(sut.allSubjects, list);
    });
  });
}
