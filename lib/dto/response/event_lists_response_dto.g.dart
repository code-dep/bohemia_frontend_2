// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_lists_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventListsResponseDTO _$EventListsResponseDTOFromJson(
        Map<String, dynamic> json) =>
    EventListsResponseDTO(
      eventLists: (json['eventLists'] as List<dynamic>?)
          ?.map((e) => EventListDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventListsResponseDTOToJson(
        EventListsResponseDTO instance) =>
    <String, dynamic>{
      'eventLists': instance.eventLists,
    };
