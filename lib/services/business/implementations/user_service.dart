import 'package:bohemia/controllers/user_data_controller.dart';
import 'package:bohemia/dto/request/login_request_dto.dart';
import 'package:bohemia/dto/request/register_request_dto.dart';
import 'package:bohemia/dto/response/common_api_response.dart';
import 'package:bohemia/dto/response/login_response_dto.dart';
import 'package:bohemia/dto/response/promoter_codes_response_dto.dart';
import 'package:bohemia/dto/response/validate_promoter_code_response_dto.dart';
import 'package:bohemia/dto/user_model.dart';
import 'package:bohemia/helpers/method_wrappers.dart';
import 'package:bohemia/services/api/interfaces/i_user_api_service.dart';
import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:get/get.dart';

class UserService implements IUserService {
  final UserDataController _userDataController = Get.find();
  final IUserApiService _userApiService = Get.find();

  @override
  String? getToken() {
    return _userDataController.userToken.value;
  }

  @override
  Future<LoginResponseDTO> login(LoginRequestDTO loginRequestDto) async {
    return await serviceMethodWrapper(() async {
      var res = await _userApiService.login(loginRequestDto);
      _userDataController.userToken.value = res.token;
      _userDataController.userToken.refresh();

      // decode token and set user data
      _userDataController.decodeAndSetToken(res.token!);

      return res;
    });
  }

  @override
  Future<void> logout() {
    return serviceMethodWrapper(() async {
      _userDataController.userToken.value = null;
      _userDataController.userToken.refresh();
    });
  }

  @override
  UserModel? getUser() {
    return _userDataController.user.value;
  }

  @override
  Future<LoginResponseDTO> register(
      RegisterRequestDTO registerRequestDto) async {
    return await serviceMethodWrapper(() async {
      var res = await _userApiService.register(registerRequestDto);
      _userDataController.userToken.value = res.token;
      _userDataController.userToken.refresh();

      // decode token and set user data
      _userDataController.decodeAndSetToken(res.token!);

      return res;
    });
  }

  @override
  Future<ValidatePromoterCodeResponseDTO> validatePromoterCode(
      String promoterCode) async {
    return await serviceMethodWrapper(() async {
      var res = await _userApiService.validatePromoterCode(promoterCode);
      return res;
    });
  }

  @override
  Future<void> storeToken(String token) {
    return serviceMethodWrapper(() async {
      _userDataController.userToken.value = token;
      _userDataController.userToken.refresh();
    });
  }

  @override
  Future<void> decodeAndSetToken(String token) {
    return serviceMethodWrapper(() async {
      _userDataController.decodeAndSetToken(token);
    });
  }

  @override
  Future<CommonApiResponse> createPromoterCode(String promoterCode) {
    return serviceMethodWrapper(() async {
      var res = await _userApiService.createPromoterCode(promoterCode);
      return res;
    });
  }

  @override
  Future<PromoterCodesResponseDTO> getPromoterCodes() {
    return serviceMethodWrapper(() async {
      var res = await _userApiService.getPromoterCodes();
      return res;
    });
  }
}
