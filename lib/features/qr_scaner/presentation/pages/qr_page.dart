import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}


class _QrScannerState extends State<QrScanner> {
  @override
  void initState() {

    super.initState();
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;

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
  Widget build(BuildContext context) {
    return   Scaffold(
            body: Stack(
              children: [
                QRView(key: qrKey, onQRViewCreated: _onQrViewCreated),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: Column(
                    children: [
                      const Spacer(flex: 160),
                      SvgPicture.asset(
                        'assets/icons/frame_icon.svg',
                        height: 280,
                        width: 280,
                      ),
                      const Spacer(flex: 70),
                      Text(
"123",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(flex: 20),
                      (result != null)
                          ? Text(
                              '${result!.code}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Colors.black),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                      const Spacer(flex: 115),
                    ],
                  ),
                ),
              ],
            ),
          );
 
  }

  _onQrViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        // setState(
        //   () {
        //     result = scanData;
        //     if (result?.code == '123') {
        //       bloc.add(AttendanceEnter());
        //     } else if (result?.code == '321') {
        //       bloc.add(AttendanceExit());
        //     } else {}
        //   },
        // );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}