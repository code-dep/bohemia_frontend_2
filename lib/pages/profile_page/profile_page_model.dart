import 'package:bohemia/dto/user_model.dart';
import 'package:bohemia/pages/login_page/login_page.dart';
import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:bohemia/services/utility_services/interfaces/i_sharedpreferences_service.dart';
import 'package:get/get.dart';

class ProfilePageModel {
  final IUserService _userService = Get.find();
  final ISharedpreferencesService _sharedPreferencesService = Get.find();
  final Rx<UserModel?> user = Rx<UserModel?>(null);

  ProfilePageModel() {
    user.value = _userService.getUser();
  }

  String getAccountType() {
    if (user.value?.isAdmin ?? false) {
      return 'Administrator';
    }
    if (user.value?.isPromoter ?? false) {
      return 'Promoter';
    }
    return 'User';
  }

  void logout() async {
    await _sharedPreferencesService.resetUserStoredCredentials();
    _userService.logout();
    Get.offAll(() => LoginPage());
  }
}
