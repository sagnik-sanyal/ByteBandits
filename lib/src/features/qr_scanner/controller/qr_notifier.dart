import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/global_providers.dart';
import '../../payment_gateway/presentation/payment_screen.dart';

part 'qr_notifier.g.dart';

@riverpod
class QrNotifier extends _$QrNotifier {
  @override
  FutureOr<void> build(QRViewController controller) async {
    controller.scannedDataStream.listen((Barcode scanData) {
      if (scanData.code != null) {
        stripQrData(scanData.code!).fold(() => null, (String r) async {
          await controller.pauseCamera();
          await ref
              .read(navigatorKeyProvider)
              .currentState!
              .pushReplacement(MaterialPageRoute<PaymentScreen>(
                builder: (_) => PaymentScreen(mccCode: r),
              ));
        });
      }
    });
    return;
  }

  Option<String> stripQrData(String data) => Option<String>.tryCatch(() {
        final List<String> splitData = data.split('&');
        return splitData[2].split('=')[1];
      });
}
