// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promoter_code_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoterCodeDTO _$PromoterCodeDTOFromJson(Map<String, dynamic> json) =>
    PromoterCodeDTO(
      Code: json['Code'] as String,
      ID: json['ID'] as String,
      Used: json['Used'] as bool,
      UsedBy: json['UsedBy'] as String?,
      CreatedBy: json['CreatedBy'] as String,
    );

Map<String, dynamic> _$PromoterCodeDTOToJson(PromoterCodeDTO instance) =>
    <String, dynamic>{
      'Code': instance.Code,
      'ID': instance.ID,
      'Used': instance.Used,
      'UsedBy': instance.UsedBy,
      'CreatedBy': instance.CreatedBy,
    };
