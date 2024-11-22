import 'package:json_annotation/json_annotation.dart';

part 'validate_promoter_code_response_dto.g.dart';

@JsonSerializable()
class ValidatePromoterCodeResponseDTO {
  final bool isValid;

  ValidatePromoterCodeResponseDTO({required this.isValid});

  factory ValidatePromoterCodeResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ValidatePromoterCodeResponseDTOFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ValidatePromoterCodeResponseDTOToJson(this);
}
