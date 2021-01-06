// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Class _$ClassFromJson(Map<String, dynamic> json) {
  return Class(
    uuid: json['uuid'] as String,
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    endTime: json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String),
    location: json['location'] as String,
    dayOfWeek: json['dayOfWeek'] as int,
  );
}

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'location': instance.location,
      'dayOfWeek': instance.dayOfWeek,
    };
