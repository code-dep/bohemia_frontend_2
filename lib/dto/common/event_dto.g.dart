// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDTO _$EventDTOFromJson(Map<String, dynamic> json) => EventDTO(
      ID: json['ID'] as String?,
      Name: json['Name'] as String?,
      Description: json['Description'] as String?,
      UserCount: (json['UserCount'] as num?)?.toDouble(),
      ListCount: (json['ListCount'] as num?)?.toDouble(),
      Images: (json['Images'] as List<dynamic>?)
          ?.map((e) => ImageDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..DateOfEvent = json['DateOfEvent'] == null
        ? null
        : DateTime.parse(json['DateOfEvent'] as String);

Map<String, dynamic> _$EventDTOToJson(EventDTO instance) => <String, dynamic>{
      'ID': instance.ID,
      'Name': instance.Name,
      'Description': instance.Description,
      'UserCount': instance.UserCount,
      'ListCount': instance.ListCount,
      'Images': instance.Images,
      'DateOfEvent': instance.DateOfEvent?.toIso8601String(),
    };
