// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjectCollection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectCollection _$SubjectCollectionFromJson(Map<String, dynamic> json) {
  return SubjectCollection(
    list: (json['list'] as List)
        ?.map((e) =>
            e == null ? null : Subject.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SubjectCollectionToJson(SubjectCollection instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
