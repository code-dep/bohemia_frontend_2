// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageDTO _$ImageDTOFromJson(Map<String, dynamic> json) => ImageDTO(
      ID: json['ID'] as String?,
      EventID: json['EventID'] as String?,
      ImageURL: json['ImageURL'] as String?,
    );

Map<String, dynamic> _$ImageDTOToJson(ImageDTO instance) => <String, dynamic>{
      'ID': instance.ID,
      'EventID': instance.EventID,
      'ImageURL': instance.ImageURL,
    };
