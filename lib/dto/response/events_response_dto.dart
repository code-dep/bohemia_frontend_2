import 'package:bohemia/dto/common/event_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'events_response_dto.g.dart';

@JsonSerializable()
class EventsResponseDTO {
  List<EventDTO>? events;

  EventsResponseDTO({this.events});

  factory EventsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$EventsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EventsResponseDTOToJson(this);
}
