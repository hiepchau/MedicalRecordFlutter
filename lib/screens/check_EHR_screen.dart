// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/basic_health_card.dart';
import 'package:medicalrecordapp/components/rounded_button.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/models/blood_donor.dart';
import 'package:medicalrecordapp/models/basic_health.dart';
import 'package:medicalrecordapp/services/EHR.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:medicalrecordapp/services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';
import 'package:toast/toast.dart';

class CheckEHRScreen extends StatefulWidget {
  static String id = 'check_EHR';

  const CheckEHRScreen({Key key}) : super(key: key);

  @override
  _CheckEHRScreenState createState() => _CheckEHRScreenState();
}

class _CheckEHRScreenState extends State<CheckEHRScreen> {
  bool loadingIndicator = true;

  final ScanController scanController = ScanController();
  final ImagePicker imagePicker = ImagePicker();
  final erhRecord = EHR(uid: Auth().getUID());
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  CollectionReference reference;
  QuerySnapshot snapshot;

  String qrCodeResult;
  List<String> qrData;
  String qrCodeType;
  String uID; 
  bool allDataFetched =
      false; 
  Donor qrDonor;
  String userName;

  basicRecord basicHealthRecord;

  Future<basicRecord> fetchRecord(String _uid) async {
    basicRecord _basicHealthRecord = basicRecord();
    final _erhRecord = EHR(uid: _uid);
    _basicHealthRecord= await _erhRecord.getRecord();
    
    setState(() {
      basicHealthRecord = _basicHealthRecord;
    });
    getUserName(_uid);
    return basicHealthRecord;
  }
  Future<void> getUserName(String _uid) async {
    String _userName;
    final database= Database(uid: _uid);
    _userName = await database.getName();
    setState(() {
      userName=_userName;
    });
  }

  void nonAsync(String _uid) {
    fetchRecord(_uid);
  }

  @override
  void initState() {
    basicHealthRecord = basicRecord();
    nonAsync(Auth().getUser().uid);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> recordData(String _uid, String _recordID) async {
    final database = Database(uid: _uid);
    final _profile = await database.getData(_uid);

    final _qrDonor = Donor(
      name: _profile.name,
      contact: _profile.contact,
      location: _profile.location,
      blood: _profile.blood,
    );
    setState(() {
      qrDonor = _qrDonor;
    });
  }



  Widget showScanOrListWidget() {
    if (allDataFetched == false) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column( 
          children: <Widget>[
          RoundedButton(
          text: 'Open Camera',
          color: Colors.lightBlue[900],
          onPressed: () async {
            String codeScanner = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.QR);

            if(codeScanner=='-1'){
              showMessage('You have turned off the Camera');
            }
            else{
            setState(() {
              qrCodeResult = codeScanner;
            });

            qrData = codeScanner.split('_');
            qrCodeType = qrData[0];
            uID = qrData[1];

            if (qrCodeType != null) {
              if (qrCodeType == 'LifeLineShare') {
              setState(() {
                loadingIndicator = true;
              });
              final _records = await fetchRecord(uID);
              setState(() {
                basicHealthRecord = _records;
                loadingIndicator = false;
                allDataFetched = true;
              });
              } else {
                showMessage('The QR is not valid');
              }
            } else {
              showMessage('The QR is not valid');
            }
            }
          },
        ),
        RoundedButton(
          text: 'Open Gallery',
          color: Colors.lightBlue[900],
          onPressed: () async {
            XFile image = await imagePicker.pickImage(source: ImageSource.gallery);
            if(image==null) {
              showMessage('You did not choose a QR!');
            } else {
              String codeScanner = await Scan.parse(image.path);

              if(codeScanner==null){
                showMessage('The QR is not valid');
              }
              else{
                setState(() {
                  qrCodeResult = codeScanner;
                });

                qrData = codeScanner.split('_');
                qrCodeType = qrData[0];
                uID = qrData[1];

                if (qrCodeType != null) {
                  if (qrCodeType == 'MedicalRecordShare') {
                  setState(() {
                    loadingIndicator = true;
                  });
                  final _records = await fetchRecord(uID);
                  setState(() {
                    basicHealthRecord = _records;
                    loadingIndicator = false;
                    allDataFetched = true;
                  });
                  }
                  else {
                    showMessage('The QR is not valid');
                  }
                }
                else {
                  showMessage('The QR is not valid');
                }
              }
          }
          },
        ),
        ]
        )
        
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: BasicHealthCard(
          basicHealthRecord: basicHealthRecord,
          userName: userName,
        ),
      );
    }
  }
  void showMessage(String txt){
    Toast.show(
      txt,
      duration:Toast.lengthLong,
      gravity:Toast.bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    loadingIndicator = false;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        title: Row(
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                height: 40.0,
                child: Image.asset(
                  'assets/images/medical_logo.png',
                ),
              ),
            ),
            const Text(
              'Check EHR',
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
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: kWaveLoadingIndicator,
        inAsyncCall: loadingIndicator,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              showScanOrListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
