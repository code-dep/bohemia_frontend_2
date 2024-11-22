import 'dart:convert';
import 'package:bohemia/services/business/interfaces/i_event_list_service.dart';
import 'package:bohemia/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScannerPageModel {
  final IEventListService _eventListService = Get.find();
  final RxBool hasScanned = false.obs;
  final cameraController = MobileScannerController();

  void onDetect(BarcodeCapture capture) async {
    if (hasScanned.value) return;

    final List<Barcode> barcodes = capture.barcodes;

    for (final barcode in barcodes) {
      if (barcode.rawValue == null) continue;

      try {
        final data = jsonDecode(barcode.rawValue!);
        if (data['listId'] != null && data['eventId'] != null) {
          hasScanned.value = true;
          await _eventListService.verifyQrCode(
              data['listId'], data['eventId'], data['userId']);
          CustomSnackbar.show(
            title: 'Success',
            message: 'Successfully subscribed to the list',
          );
        }
      } catch (e) {
        CustomSnackbar.show(
          title: 'Errore',
          message: 'Codice QR non valido',
        );
      }
    }
  }

  void dispose() {
    cameraController.dispose();
  }
}
