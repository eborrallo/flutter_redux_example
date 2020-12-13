import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter_redux_boilerplate/domain/class/class.dart';
import 'package:flutter_redux_boilerplate/domain/lecturer/lecturer.dart';
import 'package:flutter_redux_boilerplate/stubs/SubjectStub.dart';
import 'package:flutter_redux_boilerplate/stubs/TaskStub.dart';
import 'package:uuid/uuid.dart';

class ClassStub {
  static Class create(params) {
    return Class.fromJson(params);
  }

  static Class random() {
    var faker = new Faker();
    Class cls = create({
      'lecturers': List.generate(
          2,
          (index) => new Lecturer(uuid: Uuid().v4(), name: faker.person.name())
              .toJson()).toList(),
      'tasks': [],
      'subject': SubjectStub.random().toJson(),
      'duration': Duration(hours: Random().nextInt(2) + 1).inMicroseconds,
      'startTime': DateTime.now()
          .add(new Duration(
             // days: Random().nextInt(1),
              hours: Random().nextInt(20),
              minutes: Random().nextInt(59)))
          .toIso8601String(),
      'location': faker.lorem.word()
    });
    List.generate(2, (index) => cls.addTask(TaskStub.random()));
    return cls;
  }
}
