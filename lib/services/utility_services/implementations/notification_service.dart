import 'package:bohemia/services/api/interfaces/i_notification_service.dart';
import 'package:bohemia/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../interfaces/i_notification_service.dart';

class NotificationService implements INotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final INotificationApiService _notificationApiService = Get.find();

  @override
  Future<void> sendEventCreationNotification(
      String eventName, String eventDescription) async {
    // Configure notification settings
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'event_creation_channel',
      'Event Creation Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    // Show local notification
    await FlutterLocalNotificationsPlugin().show(
      0,
      'E\' stato creato un nuovo evento!',
      '$eventName: $eventDescription. Partecipa subito tramite l\'app!',
      details,
    );
  }

  @override
  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
    );

    final fCMToken = await _firebaseMessaging.getToken();

    if (fCMToken != null) {
      await _notificationApiService.saveFcmToken(fCMToken);
      debugPrint('Token FCM salvato: $fCMToken');
    } else {
      CustomSnackbar.show(
          title: 'Errore', message: 'Impossibile ottenere il token FCM');
    }
  }

  @override
  Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }
}
