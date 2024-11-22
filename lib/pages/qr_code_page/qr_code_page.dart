import 'package:bohemia/pages/qr_code_page/qr_code_page_model.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeBottomSheet extends StatelessWidget {
  final String listId;
  final String eventId;
  final String eventName;
  final QrCodePageModel _model = QrCodePageModel();

  QrCodeBottomSheet({
    super.key,
    required this.listId,
    required this.eventId,
    required this.eventName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  eventName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Center(
                  child: QrImageView(
                    backgroundColor: Theme.of(context).colorScheme.onSurface,
                    data: _model.generateQrCodeData(listId, eventId),
                    size: 300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    "Mostra il codice QR all'entrata dell'evento",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
