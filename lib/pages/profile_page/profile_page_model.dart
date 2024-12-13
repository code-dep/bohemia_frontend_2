import 'package:bohemia/dto/user_model.dart';
import 'package:bohemia/pages/login_page/login_page.dart';
import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:bohemia/services/utility_services/interfaces/i_sharedpreferences_service.dart';
import 'package:bohemia/widgets/custom_snackbar/custom_snackbar.dart';
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

  Future<void> deleteAccount(String password) async {
    try {
      if (user.value?.email == null) {
        CustomSnackbar.show(
          title: 'Error',
          message: 'User email not found.',
        );
        return;
      }

      await _userService.deleteAccount(password, user.value!.email);
      await _sharedPreferencesService.resetUserStoredCredentials();
      Get.offAll(() => LoginPage());
    } catch (e) {
      CustomSnackbar.show(
        title: 'Error',
        message: 'Failed to delete account. Please try again.',
      );
    }
  }
}
