import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controller/qr_notifier.dart';

class QrScannerScreen extends ConsumerStatefulWidget {
  const QrScannerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QrScannerScreenState();
}

class _QrScannerScreenState extends ConsumerState<QrScannerScreen> {
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scanArea = (MediaQuery.sizeOf(context).width < 400 ||
            MediaQuery.sizeOf(context).height < 400)
        ? 230.0
        : 300.0;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverAppBar(
              title: Text('Scan Your QR'),
            )
          ];
        },
        body: Center(
          child: QRView(
            key: GlobalKey(debugLabel: 'QrView'),
            onQRViewCreated: (QRViewController controller) async {
              this.controller = controller;
              ref.read(qrNotifierProvider(controller));
            },
            overlay: QrScannerOverlayShape(
              borderColor: const Color(0xFFF9ED90),
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea,
            ),
          ),
        ),
      ),
    );
  }
}
