import 'package:bohemia/services/utility_services/interfaces/i_password_service.dart';

class PasswordService implements IPasswordService {
  final RegExp lengthRegExp = RegExp(r'.{8,}');
  final RegExp upperCaseRegExp = RegExp(r'[A-Z]');
  final RegExp lowerCaseRegExp = RegExp(r'[a-z]');
  final RegExp numberRegExp = RegExp(r'[0-9]');
  final RegExp specialCharacterRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  @override
  String? isPasswordValid(String password) {
    bool noMinLength = lengthRegExp.hasMatch(password);
    bool noUpperCase = upperCaseRegExp.hasMatch(password);
    bool noLowerCase = lowerCaseRegExp.hasMatch(password);
    bool noNumber = numberRegExp.hasMatch(password);
    bool noSpecialCharacter = specialCharacterRegExp.hasMatch(password);

    bool hasRequiredUniqueChars = password.split('').toSet().isNotEmpty;

    if (!hasRequiredUniqueChars) {
      return 'Password must have unique characters';
    }

    String res = '';

    if (!noMinLength) {
      res += 'Password must be at least 8 characters long\n';
    }

    if (!noUpperCase) {
      res += 'Password must have at least one uppercase letter\n';
    }

    if (!noLowerCase) {
      res += 'Password must have at least one lowercase letter\n';
    }

    if (!noNumber) {
      res += 'Password must have at least one number\n';
    }

    if (!noSpecialCharacter) {
      res += 'Password must have at least one special character\n';
    }

    if (res.isNotEmpty) {
      return res.trim();
    }

    return null;
  }
}
