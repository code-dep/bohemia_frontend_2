// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promoter_codes_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoterCodesResponseDTO _$PromoterCodesResponseDTOFromJson(
        Map<String, dynamic> json) =>
    PromoterCodesResponseDTO(
      codes: (json['codes'] as List<dynamic>)
          .map((e) => PromoterCodeDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PromoterCodesResponseDTOToJson(
        PromoterCodesResponseDTO instance) =>
    <String, dynamic>{
      'codes': instance.codes,
    };
