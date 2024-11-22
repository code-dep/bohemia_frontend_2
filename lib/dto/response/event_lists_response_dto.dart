import 'package:bohemia/dto/common/event_list_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_lists_response_dto.g.dart';

@JsonSerializable()
class EventListsResponseDTO {
  List<EventListDTO>? eventLists;

  EventListsResponseDTO({this.eventLists});

  factory EventListsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$EventListsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EventListsResponseDTOToJson(this);
}
