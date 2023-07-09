import 'dart:developer';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qr_notifier.g.dart';

@riverpod
class QrNotifier extends _$QrNotifier {
  @override
  FutureOr<void> build(QRViewController controller) async {
    controller.scannedDataStream.listen((Barcode scanData) {
      log(scanData.code ?? 'No data');
    });
    return;
  }
}
