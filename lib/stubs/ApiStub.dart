import 'package:flutter_redux_boilerplate/domain/class/class.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:flutter_redux_boilerplate/stubs/ClassStub.dart';
import 'package:flutter_redux_boilerplate/stubs/SubjectStub.dart';
import 'package:flutter_redux_boilerplate/stubs/TaskStub.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiStub {
  List<Subject> subjects = new List<Subject>();
  List<Task> tasks = new List<Task>();
  List<Class> classes = new List<Class>();

  ApiStub() {
    List<void>.generate(20, (i) {
      Subject randomSubject = SubjectStub.random();
      var exist = this
          .subjects
          .where((element) => element.title == randomSubject.title);
      if (exist.isEmpty) {
        this.subjects.add(randomSubject);
      }
    });
    List<void>.generate(
        5,
        (i) => this.tasks.add(TaskStub.create(
            params: {'subject': (this.subjects..shuffle()).first})));

    List<void>.generate(this.subjects.length, (i) {
      Class cls = ClassStub.create(params: {
        'subject': this.subjects[i].toJson(),
      });
      tasks
          .where(
              (Task element) => element.subject.uuid == this.subjects[i].uuid)
          .toList()
          .forEach((Task _task) {
        cls.addTask(_task);
      });
      this.classes.add(cls);
    });
  }
}
