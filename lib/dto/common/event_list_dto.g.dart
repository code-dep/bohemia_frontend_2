// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventListDTO _$EventListDTOFromJson(Map<String, dynamic> json) => EventListDTO(
      id: json['id'] as String?,
      promoter_id: json['promoter_id'] as String?,
      user_id: json['user_id'] as String?,
      event_id: json['event_id'] as String?,
      name: json['name'] as String?,
      user_count: (json['user_count'] as num?)?.toInt(),
      event_name: json['event_name'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$EventListDTOToJson(EventListDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'promoter_id': instance.promoter_id,
      'user_id': instance.user_id,
      'event_id': instance.event_id,
      'name': instance.name,
      'user_count': instance.user_count,
      'event_name': instance.event_name,
      'status': instance.status,
    };
