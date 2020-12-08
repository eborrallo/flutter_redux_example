import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';

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
  static Subject create(params) {
    return Subject.fromJson(params);
  }

  static Subject random() {
   
    return create({
      'title': (subjectList..shuffle()).first,
    });
  }
}
