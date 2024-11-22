import 'package:json_annotation/json_annotation.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDTO {
  String? token;

  LoginResponseDTO({this.token});

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDTOToJson(this);
}
