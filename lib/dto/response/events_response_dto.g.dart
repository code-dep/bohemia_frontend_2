// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsResponseDTO _$EventsResponseDTOFromJson(Map<String, dynamic> json) =>
    EventsResponseDTO(
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => EventDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventsResponseDTOToJson(EventsResponseDTO instance) =>
    <String, dynamic>{
      'events': instance.events,
    };
