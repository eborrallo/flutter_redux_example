import 'dart:convert';

import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

import 'SubjectStub.dart';

class TaskStub {
  static Task create({params}) {
    var map = params ?? new Map<String, dynamic>();
    Subject subject = map['subject'] ?? SubjectStub.random();

    var _params = {
      'uuid': map['uuid'] ?? Uuid().v4(),
      'title': map['title'] ?? subject.title + " task",
      'subject': subject.toJson(),
      'deliveryDate': map['deliveryDate'] ??
          DateTime.now()
              .add(new Duration(
                  days: Random().nextInt(7),
                  hours: Random().nextInt(20),
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
