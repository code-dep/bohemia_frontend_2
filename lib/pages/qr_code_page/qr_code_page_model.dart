import 'dart:convert';

import 'package:bohemia/services/business/interfaces/i_user_service.dart';
import 'package:get/get.dart';

class QrCodePageModel {
  final IUserService _userService = Get.find();

  String generateQrCodeData(String listId, String eventId) {
    // build a json
    return jsonEncode({
      'userId': _userService.getUser()?.userId,
      'listId': listId,
      'eventId': eventId,
    });
  }
}
