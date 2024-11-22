import 'package:json_annotation/json_annotation.dart';

part 'register_request_dto.g.dart';

@JsonSerializable()
class RegisterRequestDTO {
  final String name;
  final String surname;
  final String email;
  final String username;
  final String instagram;
  final String password;
  final String? promoterCode;

  RegisterRequestDTO(
    this.email,
    this.username,
    this.instagram,
    this.password,
    this.promoterCode,
    this.name,
    this.surname,
  );

  factory RegisterRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestDTOToJson(this);
}
