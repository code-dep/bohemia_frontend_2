import 'package:bohemia/services/utility_services/interfaces/i_password_service.dart';
import 'package:bohemia/services/validators/interfaces/i_user_validator_service.dart';
import 'package:get/get.dart';

class UserValidatorService implements IUserValidatorService {
  final IPasswordService _passwordService = Get.find();

  @override
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    return _passwordService.isPasswordValid(password);
  }

  @override
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }

    if (username.length < 3) {
      return 'Username must be at least 3 characters long';
    }

    return null;
  }
}
