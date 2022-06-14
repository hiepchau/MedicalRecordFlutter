// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:medicalrecordapp/components/rounded_button.dart';

class QrCodeScannerScreen extends StatefulWidget {
  static String id = "qr_code_scanner";

  const QrCodeScannerScreen({Key key}) : super(key: key);

  @override
  _QrCodeScannerScreenState createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  String qrCodeResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        title: Row(
          children: [
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 40.0,
                child: Image.asset(
                  'assets/images/medical_logo.png',
                ),
              ),
            ),
            const Text(
              'Scan QR Code',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nexa Bold',
                fontSize: 24,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RoundedButton(
            text: 'Open Camera',
            color: Colors.lightBlue[900],
            onPressed: () async {
              String codeScanner = await FlutterBarcodeScanner.scanBarcode(
                  '#ff6666', 'Cancel', true, ScanMode.QR);
              setState(() {
                qrCodeResult = codeScanner;
              });
            },
          ),
        ],
      ),
    );
  }
}
