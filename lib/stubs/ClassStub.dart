import 'dart:convert';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter_redux_boilerplate/domain/class/class.dart';
import 'package:flutter_redux_boilerplate/domain/lecturer/lecturer.dart';
import 'package:uuid/uuid.dart';

class ClassStub {
  static Class create({params}) {
    var faker = new Faker();
    var map = params ?? new Map<String, dynamic>();
    DateTime startDate = DateTime.now().add(new Duration(
        // days: Random().nextInt(1),
        hours: Random().nextInt(20),
        minutes: Random().nextInt(59)));
    var _params = {
      'uuid': map['uuid'] ?? Uuid().v4(),
      'lecturers': map['lecturers'] ??
          List.generate(
              2,
              (index) =>
                  new Lecturer(uuid: Uuid().v4(), name: faker.person.name())
                      .toJson()).toList(),
      'tasks': [],
      'duration': map['duration'] ??
          Duration(hours: Random().nextInt(2) + 1).inMicroseconds,
      'startTime': map['startTime'] ?? startDate.toIso8601String(),
      'endTime': map['endTime'] ??
          startDate
              .add(new Duration(
                  // days: Random().nextInt(1),
                  hours: Random().nextInt(20),
                  minutes: Random().nextInt(59)))
              .toIso8601String(),
      'location': map['location'] ?? faker.lorem.word(),
      'dayOfWeek': map['dayOfWeek'] ?? new Random().nextInt(6),
    };
    Class cls = new Class.fromJson(_params);
    // List.generate(
    //     map['tasks'] != null ? map['tasks'].length : 2,
    //     (index) => cls.addTask(map['tasks'] != null
    //         ? Task.fromJson(map['tasks'][index])
    //         : TaskStub.random()));
    return cls;
  }

  static Class random() {
    return create();
  }
}
