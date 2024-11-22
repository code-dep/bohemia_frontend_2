// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'event_list_dto.g.dart';

@JsonSerializable()
class EventListDTO {
  String? id;
  String? promoter_id;
  String? user_id;
  String? event_id;
  String? name;
  int? user_count;
  String? event_name;
  String? status;

  EventListDTO(
      {required this.id,
      required this.promoter_id,
      required this.user_id,
      required this.event_id,
      required this.name,
      required this.user_count,
      required this.event_name,
      required this.status});

  factory EventListDTO.fromJson(Map<String, dynamic> json) =>
      _$EventListDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EventListDTOToJson(this);
}
