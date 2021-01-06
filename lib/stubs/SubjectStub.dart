import 'dart:math';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/domain/subject/subject.dart';
import 'package:flutter_redux_boilerplate/stubs/ClassStub.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_redux_boilerplate/domain/extensions/color_extension.dart';

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
  static List colors = [
    Colors.red.toHex(),
    Colors.green.toHex(),
    Colors.purple.toHex(),
    Colors.yellow.toHex(),
    Colors.blue.toHex(),
  ];
  static Color randomOpaqueColor() {
    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
  }

  static Subject create({params}) {
    var map = params ?? new Map<String, dynamic>();
    var list = List.generate(7, (index) => index)..shuffle();
    var daysOfweek = list.take(3).toList();

    var _params = {
      'uuid': map['uuid'] ?? Uuid().v4(),
      'title': map['title'] ?? (subjectList..shuffle()).first,
      'description':
          map['description'] ?? (new Faker()).lorem.sentences(3).join('. '),
      'color': map['color'] ?? randomOpaqueColor().toHex(),
      'tasks': map['tasks'] ?? [],
      'classes': map['classes'] ??
          List.generate(
              3,
              (index) =>
                  ClassStub.create(params: {'dayOfWeek': daysOfweek[index]})
                      .toJson()),
    };

    return Subject.fromJson(_params);
  }

  static Subject random() {
    return create();
  }
}
