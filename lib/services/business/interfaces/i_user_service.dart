import 'package:bohemia/dto/request/login_request_dto.dart';
import 'package:bohemia/dto/request/register_request_dto.dart';
import 'package:bohemia/dto/response/common_api_response.dart';
import 'package:bohemia/dto/response/login_response_dto.dart';
import 'package:bohemia/dto/response/promoter_codes_response_dto.dart';
import 'package:bohemia/dto/response/validate_promoter_code_response_dto.dart';
import 'package:bohemia/dto/user_model.dart';

abstract class IUserService {
  String? getToken();
  UserModel? getUser();

  Future<LoginResponseDTO> login(LoginRequestDTO loginRequestDto);
  Future<void> logout();
  Future<LoginResponseDTO> register(RegisterRequestDTO registerRequestDto);
  Future<ValidatePromoterCodeResponseDTO> validatePromoterCode(
      String promoterCode);
  Future<void> storeToken(String token);
  Future<void> decodeAndSetToken(String token);
  Future<CommonApiResponse> createPromoterCode(String promoterCode);
  Future<PromoterCodesResponseDTO> getPromoterCodes();
  Future<CommonApiResponse> deleteAccount(String password, String email);
}
