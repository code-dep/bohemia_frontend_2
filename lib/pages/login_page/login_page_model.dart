import 'package:bohemia/dto/request/login_request_dto.dart';
import 'package:bohemia/pages/tab_page/tab_page.dart';
import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:bohemia/services/ui_services/interfaces/i_loader_service.dart';
import 'package:bohemia/services/utility_services/interfaces/i_sharedpreferences_service.dart';
import 'package:bohemia/services/validators/interfaces/i_user_validator_service.dart';
import 'package:bohemia/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageModel {
  final ILoaderService _loaderService = Get.find();
  final IUserService _userService = Get.find();
  final IUserValidatorService _userValidatorService = Get.find();
  final ISharedpreferencesService _sharedPreferencesService = Get.find();

  final formkey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Rx<bool> isPasswordVisible = Rx<bool>(false);

  void gotoRegisterPage() {
    // Get.to(RegisterPage());
  }

  void doLogin() async {
    if (formkey.currentState!.validate()) {
      try {
        _loaderService.showLoader();
        final token = await _userService.login(LoginRequestDTO(
          username: usernameController.text,
          password: passwordController.text,
        ));

        // Store the token
        await _sharedPreferencesService.storeToken(token.token!);

        Get.offAll(() => TabPage());
      } on Exception {
        _loaderService.dismissLoader();
        CustomSnackbar.show(
          title: 'Error',
          message: 'An error occurred while logging in',
        );
      }
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String? validateUsername(String? value) {
    return _userValidatorService.validateUsername(value);
  }

  String? validatePassword(String? value) {
    return _userValidatorService.validatePassword(value);
  }
}
