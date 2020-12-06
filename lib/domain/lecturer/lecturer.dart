import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'lecturer.g.dart';

@JsonSerializable(nullable: false)
class Lecturer {
  final String uuid;
  final String name;

  Lecturer({this.uuid, this.name});

  factory Lecturer.fromJson(Map<String, dynamic> json) => _$LecturerFromJson(json);
  Map<String, dynamic> toJson() => _$LecturerToJson(this);
  
@override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
