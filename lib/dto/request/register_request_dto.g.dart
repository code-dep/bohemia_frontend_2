// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestDTO _$RegisterRequestDTOFromJson(Map<String, dynamic> json) =>
    RegisterRequestDTO(
      json['email'] as String,
      json['username'] as String,
      json['instagram'] as String,
      json['password'] as String,
      json['promoterCode'] as String?,
      json['name'] as String,
      json['surname'] as String,
    );

Map<String, dynamic> _$RegisterRequestDTOToJson(RegisterRequestDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'username': instance.username,
      'instagram': instance.instagram,
      'password': instance.password,
      'promoterCode': instance.promoterCode,
    };
