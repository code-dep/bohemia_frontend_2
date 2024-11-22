import 'package:bohemia/dto/request/register_request_dto.dart';
import 'package:bohemia/pages/tab_page/tab_page.dart';
import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:bohemia/services/ui_services/interfaces/i_loader_service.dart';
import 'package:bohemia/services/utility_services/interfaces/i_sharedpreferences_service.dart';
import 'package:bohemia/services/validators/interfaces/i_user_validator_service.dart';
import 'package:bohemia/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPageModel {
  final ILoaderService _loaderService = Get.find();
  final IUserService _userService = Get.find();
  final IUserValidatorService _userValidatorService = Get.find();
  final ISharedpreferencesService _sharedPreferencesService = Get.find();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final instagramController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final promoterCodeController = TextEditingController();
  Rx<bool> isPasswordVisible = Rx<bool>(false);
  Rx<bool> isConfirmPasswordVisible = Rx<bool>(false);

  void doRegister() async {
    if (formKey.currentState!.validate()) {
      try {
        _loaderService.showLoader();
        final response = await _userService.register(RegisterRequestDTO(
          emailController.text,
          usernameController.text,
          instagramController.text,
          passwordController.text,
          promoterCodeController.text,
          nameController.text,
          surnameController.text,
        ));

        // Store the token
        await _sharedPreferencesService.storeToken(response.token!);

        Get.offAll(() => TabPage());
      } on Exception {
        _loaderService.dismissLoader();
        CustomSnackbar.show(
          title: 'Errore',
          message: 'Errore durante la registrazione',
        );
      }
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateSurname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Surname is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validateUsername(String? value) {
    return _userValidatorService.validateUsername(value);
  }

  String? validatePassword(String? value) {
    return _userValidatorService.validatePassword(value);
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return _userValidatorService.validatePassword(value);
  }

  void validatePromoterCode() async {
    if (promoterCodeController.text.isEmpty) {
      return;
    }
    var res =
        await _userService.validatePromoterCode(promoterCodeController.text);
    if (res.isValid) {
      CustomSnackbar.show(
        title: 'Success',
        message: 'Codice promotore valido',
      );
    } else {
      CustomSnackbar.show(
        title: 'Errore',
        message: 'Codice promotore non valido',
      );
    }
  }
}
