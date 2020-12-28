// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  return Subject(
    json['description'] as String,
    json['color'] as String,
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
      'color': instance.color,
    };
