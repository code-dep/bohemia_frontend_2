import 'package:bohemia/pages/login_page/login_page.dart';
import 'package:bohemia/pages/tab_page/tab_page.dart';
import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:bohemia/services/utility_services/interfaces/i_sharedpreferences_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainModel {
  final ISharedpreferencesService _sharedPreferencesService = Get.find();
  final IUserService _userService = Get.find();

  Future<Widget> getInitialScreen() async {
    try {
      final token = await _sharedPreferencesService.getToken() ?? '';

      if (token.isNotEmpty) {
        await _userService.storeToken(token);
        _userService.decodeAndSetToken(token);
        return TabPage();
      } else {
        await _sharedPreferencesService.resetUserStoredCredentials();
        return LoginPage();
      }
    } catch (e) {
      await _sharedPreferencesService.resetUserStoredCredentials();
      return LoginPage();
    }
  }
}
