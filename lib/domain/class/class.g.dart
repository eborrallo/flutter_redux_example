// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Class _$ClassFromJson(Map<String, dynamic> json) {
  return Class(
    uuid: json['uuid'] as String,
    tasks: (json['tasks'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    subject: json['subject'] == null
        ? null
        : Subject.fromJson(json['subject'] as Map<String, dynamic>),
    duration: json['duration'] == null
        ? null
        : Duration(microseconds: json['duration'] as int),
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    location: json['location'] as String,
    dayOfWeek: json['dayOfWeek'] as int,
  );
}

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'tasks': instance.tasks,
      'subject': instance.subject,
      'duration': instance.duration?.inMicroseconds,
      'startTime': instance.startTime?.toIso8601String(),
      'location': instance.location,
      'dayOfWeek': instance.dayOfWeek,
    };
