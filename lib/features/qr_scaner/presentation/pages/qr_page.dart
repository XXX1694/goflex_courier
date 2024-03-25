import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goflex_courier/features/deliveried/presentation/bloc/deliveried_bloc.dart';
import 'package:goflex_courier/features/delivery_accept/presentation/bloc/delivery_accept_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({
    super.key,
    required this.id,
    required this.status,
  });
  final int id;
  final String status;
  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  late DeliveryAcceptBloc acceptBloc;
  late DeliveriedBloc deliviredBloc;
  @override
  void initState() {
    acceptBloc = BlocProvider.of<DeliveryAcceptBloc>(context);
    deliviredBloc = BlocProvider.of<DeliveriedBloc>(context);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          'QR сканер',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          QRView(key: qrKey, onQRViewCreated: _onQrViewCreated),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Column(
              children: [
                const Spacer(flex: 120),
                SvgPicture.asset(
                  'assets/icons/frame_icon.svg',
                  height: 280,
                  width: 280,
                ),
                const Spacer(flex: 70),
                const Text(
                  "Отсканируйте QR",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 20),
                (result != null)
                    ? Text(
                        '${result!.code}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : const Text(
                        'Тут будет отображатья данные QR кода',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
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
        setState(
          () {
            result = scanData;
            if (kDebugMode) {
              print(result);
            }
            if (result?.code.toString() == widget.id.toString()) {
              if (widget.status == 'Accept') {
                acceptBloc.add(AcceptDelivery(id: widget.id));
              } else if (widget.status == 'Delivered') {
                deliviredBloc.add(
                  Delivered(
                    id: widget.id,
                    distance: 0,
                  ),
                );
              }
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
