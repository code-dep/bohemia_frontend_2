import 'package:json_annotation/json_annotation.dart';

import '../common/promoter_code_dto.dart';

part 'promoter_codes_response_dto.g.dart';

@JsonSerializable()
class PromoterCodesResponseDTO {
  final List<PromoterCodeDTO> codes;

  PromoterCodesResponseDTO({required this.codes});

  factory PromoterCodesResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$PromoterCodesResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PromoterCodesResponseDTOToJson(this);
}
