// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  return Subject(
    (json['classes'] as List)
        ?.map(
            (e) => e == null ? null : Class.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    description: json['description'] as String,
    color: json['color'] as String,
    uuid: json['uuid'] as String,
    title: json['title'] as String,
    lecturers: (json['lecturers'] as List)
        ?.map((e) =>
            e == null ? null : Lecturer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'description': instance.description,
      'lecturers': instance.lecturers,
      'classes': instance.classes,
      'color': instance.color,
    };
