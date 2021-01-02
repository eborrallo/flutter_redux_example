import 'package:flutter_redux_boilerplate/application/notifier/SubjectNotifier.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/infraestructure/task/SubjectRepository.dart';
import 'package:flutter_redux_boilerplate/injections.dart';
import 'package:flutter_redux_boilerplate/stubs/SubjectStub.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class SubjectRepositoryMock extends Mock implements SubjectRepository {}

void main() {
  group('SubjectNotifier', () {
    SubjectNotifier sut;
    String uuid = Uuid().v4();

    List<Subject> list = [
      SubjectStub.random(),
      SubjectStub.create(params: {
        'uuid': uuid,
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
    testWidgets('Add subjects', (WidgetTester tester) async {
      await untilCalled(repository.findAll());
      String _uuid = Uuid().v4();
      Subject subject = SubjectStub.create(params: {
        'uuid': _uuid,
      });
      sut.addSubject(subject);
      expect(sut.allSubjects.indexOf(subject), isNot(-1));
      var subjectIndex = sut.allSubjects.indexOf(subject);
      expect(sut.allSubjects[subjectIndex], subject);
    });

    testWidgets('Delete subject', (WidgetTester tester) async {
      await untilCalled(repository.findAll());
      sut.delete(uuid);
      expect(() => list.firstWhere((element) => element.uuid == uuid),
          throwsA(isA<StateError>()));
    });

    testWidgets('Select to edit subject', (WidgetTester tester) async {
      await untilCalled(repository.findAll());
      var subject = SubjectStub.random();
      sut.edit(subject);
      expect(sut.subjectToEdit, subject);
    });
    testWidgets('Update subject', (WidgetTester tester) async {
      await untilCalled(repository.findAll());
      Subject subject = SubjectStub.create(params: {
        'title': 'testTitle',
        'uuid': uuid,
      });
      sut.updateSubject(subject);
      expect(
          sut.allSubjects.firstWhere((element) => element.uuid == uuid).title,
          subject.title);
    });
  });
}
