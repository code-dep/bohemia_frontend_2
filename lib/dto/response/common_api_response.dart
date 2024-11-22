import 'package:json_annotation/json_annotation.dart';

part 'subscribe_response_dto.g.dart';

@JsonSerializable()
class CommonApiResponse {
  String? message;

  CommonApiResponse({this.message});

  factory CommonApiResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscribeResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SubscribeResponseDTOToJson(this);
}
