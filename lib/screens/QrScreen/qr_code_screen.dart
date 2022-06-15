// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatefulWidget {
  final String appBarTitle;
  final qrCodeData;

  const QrCodeScreen({
    Key key,
    @required this.appBarTitle,
    @required this.qrCodeData,
  }) : super(key: key);

  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
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
            Text(
              widget.appBarTitle,
              style: const TextStyle(
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
      body: Container(
        color: Colors.lightBlue[50],
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: QrImage(
              data: widget.qrCodeData,
              errorCorrectionLevel: QrErrorCorrectLevel.M,
              gapless: true,
              foregroundColor: Colors.black,
              version: QrVersions.auto,
              size: MediaQuery.of(context).size.width / 1.25,
            ),
          ),
        ),
      ),
    );
  }
}
