// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'image_dto.g.dart';

@JsonSerializable()
class ImageDTO {
  String? ID;
  String? EventID;
  String? ImageURL;

  ImageDTO({this.ID, this.EventID, this.ImageURL});

  factory ImageDTO.fromJson(Map<String, dynamic> json) =>
      _$ImageDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ImageDTOToJson(this);
}
