// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'promoter_code_dto.g.dart';

//  {
//             "CreatedAt": "2024-11-17T18:15:33.346823+01:00",
//             "UpdatedAt": "2024-11-17T18:16:14.275572+01:00",
//             "DeletedAt": null,
//             "ID": "ff92a810-08d6-4e90-b5ac-d333e29090e8",
//             "Code": "Omar Sbai",
//             "Used": true,
//             "UsedBy": null,
//             "CreatedBy": "31d5e3d1-802f-42f3-8f67-a88c78d46442"
//         }

@JsonSerializable()
class PromoterCodeDTO {
  final String Code;
  final String ID;
  final bool Used;
  final String? UsedBy;
  final String CreatedBy;

  PromoterCodeDTO({
    required this.Code,
    required this.ID,
    required this.Used,
    required this.UsedBy,
    required this.CreatedBy,
  });

  factory PromoterCodeDTO.fromJson(Map<String, dynamic> json) =>
      _$PromoterCodeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PromoterCodeDTOToJson(this);
}
