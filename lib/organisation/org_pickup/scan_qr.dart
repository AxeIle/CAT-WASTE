import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  String scannedText = 'Scan a QR code';

  Future<void> scanQRCode() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        scannedText = qrResult;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          scannedText = 'Camera permission was denied';
        });
      } else {
        setState(() {
          scannedText = 'Unknown error: $e';
        });
      }
    } on FormatException {
      setState(() {
        scannedText = 'User returned without scanning';
      });
    } catch (e) {
      setState(() {
        scannedText = 'Unknown error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              scannedText,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: scanQRCode,
              child: Text('Scan QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
