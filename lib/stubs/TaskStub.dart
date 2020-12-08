import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/domain/task/task.dart';
import 'package:uuid/uuid.dart';

import 'SubjectStub.dart';

class TaskStub {
  static Task create(params) {
    return Task.fromJson(params);
  }

  static Task random() {
    Subject subject = SubjectStub.random();
    return create({
      'uuid': Uuid().v4(),
      'title': subject.title + " task",
      'subject': subject.toJson(),
      'deliveryDate': DateTime.now().toString(),
      'done': ([true, false]..shuffle()).first,
    });
  }
}
