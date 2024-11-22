import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show({
    required String title,
    required String message,
    Duration? duration,
  }) {
    final snackbarDuration = duration ?? const Duration(seconds: 3);
    final progressController = ValueNotifier<double>(1.0);

    // Animate the progress bar
    Future.delayed(Duration.zero, () {
      const animationDuration = Duration(milliseconds: 100);
      progressController.value = 1.0;
      Future.delayed(animationDuration, () {
        progressController.value = 0.0;
      });
    });

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.surface,
      colorText: Get.theme.colorScheme.onSurface,
      borderRadius: 0,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      duration: snackbarDuration,
      borderWidth: 1,
      borderColor: Get.theme.dividerColor,
      boxShadows: [
        BoxShadow(
          color: Get.theme.colorScheme.onSurface.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: Get.theme.colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<double>(
            valueListenable: progressController,
            builder: (context, value, child) {
              return TweenAnimationBuilder<double>(
                duration: snackbarDuration,
                curve: Curves.linear,
                tween: Tween<double>(
                  begin: 1.0,
                  end: 0.0,
                ),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: Get.theme.dividerColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Get.theme.colorScheme.primary,
                    ),
                    minHeight: 2,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
