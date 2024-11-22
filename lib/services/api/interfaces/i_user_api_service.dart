import 'package:bohemia/dto/request/login_request_dto.dart';
import 'package:bohemia/dto/request/register_request_dto.dart';
import 'package:bohemia/dto/response/common_api_response.dart';
import 'package:bohemia/dto/response/login_response_dto.dart';
import 'package:bohemia/dto/response/promoter_codes_response_dto.dart';
import 'package:bohemia/dto/response/validate_promoter_code_response_dto.dart';

abstract class IUserApiService {
  Future<LoginResponseDTO> login(LoginRequestDTO loginRequestDto);
  Future<LoginResponseDTO> register(RegisterRequestDTO registerRequestDto);
  Future<ValidatePromoterCodeResponseDTO> validatePromoterCode(
      String promoterCode);
  Future<PromoterCodesResponseDTO> getPromoterCodes();
  Future<CommonApiResponse> createPromoterCode(String promoterCode);
}
