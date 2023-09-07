import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sizer/sizer.dart';

import '../const/const.dart';
import 'order_details.dart';



class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 10, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = 69.0.w;

    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: mainTextColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {

      try{
      setState(() {
        result = scanData;
        if(result!.code!.contains("OrderHereLaSpigad'Oro")){

        print( 'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}');
        String originalString2 = result!.code!;
        String stringToRemove2 = "OrderHereLaSpigad'Oro";

        String result2 = originalString2.replaceAll(stringToRemove2, '');
        print(result2);

        controller.pauseCamera();
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OwnerOrderDetails(id: int.parse(result2))));
        }

      });
    }
    catch(e){
      print(e);
    }

    });
  }

  Future<void> _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) async {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      var status = await Permission.camera.status;
      if (!status.isGranted) {
        var result = await Permission.camera.request();
        if (!result.isGranted) {
          // Handle the case when the permission is not granted
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('no Permission')),
          );
          return;
        }
      }

    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}