import 'package:bohemia/helpers/method_wrappers.dart';
import 'package:bohemia/services/api/interfaces/i_base_api_service.dart';
import 'package:bohemia/services/api/interfaces/i_notification_service.dart';
import 'package:get/get.dart';

class NotificationApiService implements INotificationApiService {
  final IBaseApiService _baseApiService = Get.find();
  @override
  Future<void> saveFcmToken(String fcmToken) async {
    return await apiMethodWrapper(() async {
      await _baseApiService.post('/fcm', {'fcmToken': fcmToken});
    });
  }
}
