abstract class INotificationService {
  Future<void> initialize();
  Future<void> sendEventCreationNotification(
      String eventName, String eventDescription);
  Future<String?> getFCMToken();
}
