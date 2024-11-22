// ignore_for_file: non_constant_identifier_names

import 'package:bohemia/dto/common/image_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_dto.g.dart';

@JsonSerializable()
class EventDTO {
  String? ID;
  String? Name;
  String? Description;
  double? UserCount;
  double? ListCount;
  List<ImageDTO>? Images;
  DateTime? DateOfEvent;

  EventDTO(
      {this.ID,
      this.Name,
      this.Description,
      this.UserCount,
      this.ListCount,
      this.Images});

  factory EventDTO.fromJson(Map<String, dynamic> json) =>
      _$EventDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EventDTOToJson(this);
}
