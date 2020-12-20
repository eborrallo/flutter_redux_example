// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classCollection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassCollection _$ClassCollectionFromJson(Map<String, dynamic> json) {
  return ClassCollection(
    list: (json['list'] as List)
        ?.map(
            (e) => e == null ? null : Class.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ClassCollectionToJson(ClassCollection instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
