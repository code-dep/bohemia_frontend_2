import 'package:bohemia/pages/qr_code_scanner_page/qr_code_scanner_model.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScannerPage extends StatelessWidget {
  final QrCodeScannerPageModel _model = QrCodeScannerPageModel();

  QrCodeScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanna il codice QR'),
      ),
      body: MobileScanner(
        controller: _model.cameraController,
        onDetect: _model.onDetect,
        overlayBuilder: (context, overlay) => QRScannerOverlay(),
      ),
    );
  }
}

class QRScannerOverlay extends StatelessWidget {
  const QRScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: QRScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 250,
        ),
      ),
    );
  }
}

class QRScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;

  const QRScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderWidth = 1.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 80),
    this.borderRadius = 0,
    this.borderLength = 40,
    this.cutOutSize = 250,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRect(rect)
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: rect.center,
          width: cutOutSize,
          height: cutOutSize,
        ),
        Radius.circular(borderRadius),
      ))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final height = rect.height;
    final cutOutSize = this.cutOutSize;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final boxPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - cutOutSize / 2,
      rect.top + height / 2 - cutOutSize / 2,
      cutOutSize,
      cutOutSize,
    );

    canvas
      ..saveLayer(rect, backgroundPaint)
      ..drawRect(rect, backgroundPaint)
      ..drawRRect(
        RRect.fromRectAndRadius(
          cutOutRect,
          Radius.circular(borderRadius),
        ),
        boxPaint,
      )
      ..restore();

    // Draw corners
  }

  @override
  ShapeBorder scale(double t) {
    return QRScannerOverlayShape(
      borderColor: borderColor.withOpacity(t),
      borderWidth: borderWidth * t,
      borderRadius: borderRadius * t,
    );
  }
}
