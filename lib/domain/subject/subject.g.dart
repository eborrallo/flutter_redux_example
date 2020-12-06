// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  return Subject(
    uuid: json['uuid'] as String,
    title: json['title'] as String,
    lecturers: (json['lecturers'] as List)
        .map((e) => Lecturer.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'lecturers': instance.lecturers,
    };
