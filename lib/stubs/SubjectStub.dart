import 'dart:convert';

import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:uuid/uuid.dart';

class SubjectStub {
  static List subjectList = [
    "Mathematics",
    "Science",
    // "Health",
    // "Handwriting",
    "Physical Education (P.E.)",
    "Art",
    "Music"
  ];
  static Subject create({params}) {
    var map = params != null ? jsonDecode(params) : new Map<String, dynamic>();
    var _params = {
      'uuid': map['uuid'] ?? Uuid().v4(),
      'title': map['title'] ?? (subjectList..shuffle()).first,
    };

    return Subject.fromJson(_params);
  }

  static Subject random() {
    return create();
  }
}
