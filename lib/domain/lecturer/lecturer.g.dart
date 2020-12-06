// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecturer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lecturer _$LecturerFromJson(Map<String, dynamic> json) {
  return Lecturer(
    uuid: json['uuid'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$LecturerToJson(Lecturer instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
    };
