// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskCollection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskCollection _$TaskCollectionFromJson(Map<String, dynamic> json) {
  return TaskCollection(
    list: (json['list'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TaskCollectionToJson(TaskCollection instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
