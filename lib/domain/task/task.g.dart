// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    uuid: json['uuid'] as String,
    title: json['title'] as String,
    subject: json['subject'] == null
        ? null
        : Subject.fromJson(json['subject'] as Map<String, dynamic>),
    deliveryDate: json['deliveryDate'] == null
        ? null
        : DateTime.parse(json['deliveryDate'] as String),
    done: json['done'] as bool,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'subject': instance.subject.toJson(),
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
      'done': instance.done,
    };
