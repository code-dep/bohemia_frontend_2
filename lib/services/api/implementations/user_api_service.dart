import 'package:bohemia/dto/request/login_request_dto.dart';
import 'package:bohemia/dto/request/register_request_dto.dart';
import 'package:bohemia/dto/response/common_api_response.dart';
import 'package:bohemia/dto/response/login_response_dto.dart';
import 'package:bohemia/dto/response/promoter_codes_response_dto.dart';
import 'package:bohemia/dto/response/validate_promoter_code_response_dto.dart';
import 'package:bohemia/helpers/method_wrappers.dart';
import 'package:bohemia/services/api/interfaces/i_base_api_service.dart';
import 'package:bohemia/services/api/interfaces/i_user_api_service.dart';
import 'package:get/get.dart';

class UserApiService implements IUserApiService {
  final IBaseApiService _baseApiService = Get.find();

  @override
  Future<LoginResponseDTO> login(LoginRequestDTO loginRequestDto) {
    return apiMethodWrapper(() async {
      var response = await _baseApiService.post(
        '/login',
        loginRequestDto.toJson(),
      );

      var dict = response.data as Map<String, dynamic>;

      return LoginResponseDTO.fromJson(dict);
    });
  }

  @override
  Future<LoginResponseDTO> register(RegisterRequestDTO registerRequestDto) {
    return apiMethodWrapper(() async {
      var response = await _baseApiService.post(
        '/register',
        registerRequestDto.toJson(),
      );

      var dict = response.data as Map<String, dynamic>;

      return LoginResponseDTO.fromJson(dict);
    });
  }

  @override
  Future<ValidatePromoterCodeResponseDTO> validatePromoterCode(
      String promoterCode) {
    return apiMethodWrapper(() async {
      var response =
          await _baseApiService.get('/verify-code?code=$promoterCode');

      var dict = response.data as Map<String, dynamic>;

      return ValidatePromoterCodeResponseDTO.fromJson(dict);
    });
  }

  @override
  Future<CommonApiResponse> createPromoterCode(String promoterCode) {
    return apiMethodWrapper(() async {
      var response = await _baseApiService.post(
        '/admin/promoter-codes',
        {'code': promoterCode},
      );

      var dict = response.data as Map<String, dynamic>;

      return CommonApiResponse.fromJson(dict);
    });
  }

  @override
  Future<PromoterCodesResponseDTO> getPromoterCodes() {
    return apiMethodWrapper(() async {
      var response = await _baseApiService.get('/admin/promoter-codes');

      var dict = response.data as Map<String, dynamic>;

      return PromoterCodesResponseDTO.fromJson(dict);
    });
  }

  @override
  Future<CommonApiResponse> deleteAccount(String password, String email) {
    return apiMethodWrapper(() async {
      var response = await _baseApiService.post('/account', {
        'password': password,
        'email': email,
      });
      var dict = response.data as Map<String, dynamic>;
      return CommonApiResponse.fromJson(dict);
    });
  }
}
