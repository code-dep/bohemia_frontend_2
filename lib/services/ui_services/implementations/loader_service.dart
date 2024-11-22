import 'package:bohemia/services/ui_services/interfaces/i_loader_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderService implements ILoaderService {
  bool isLoaderVisible = false;

  @override
  void dismissLoader() {
    if (isLoaderVisible) {
      Get.back();
      isLoaderVisible = false;
    }
  }

  @override
  void showLoader() {
    if (!isLoaderVisible) {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      isLoaderVisible = true;
    }
  }
}
