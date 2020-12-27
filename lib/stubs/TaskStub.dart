import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

import 'SubjectStub.dart';

class TaskStub {
  static Task create({params}) {
    var map = params ?? new Map<String, dynamic>();
    Subject subject = map['subject'] ?? SubjectStub.random();
    var faker = new Faker();

    var _params = {
      'uuid': map['uuid'] ?? Uuid().v4(),
      'title': map['title'] ?? faker.lorem.sentence(),
      'subject': subject.toJson(),
      'description': faker.lorem.sentences(20).join('. '),
      'deliveryDate': map['deliveryDate'] ??
          DateTime.now().subtract(Duration(days: 3))
              .add(new Duration(
                  days: Random().nextInt(5),
                  hours: Random().nextInt(10),
                  minutes: Random().nextInt(59)))
              .toString(),
      'done': map['done'] ?? ([true, false]..shuffle()).first,
    };

    return Task.fromJson(_params);
  }

  static Task random() {
    return create();
  }
}
