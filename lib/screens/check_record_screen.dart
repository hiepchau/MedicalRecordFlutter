import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicalrecordapp/components/diagnosis_card_list.dart';
import 'package:medicalrecordapp/components/rounded_button.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/models/blood_donor.dart';
import 'package:medicalrecordapp/models/diagnosis.dart';
import 'package:medicalrecordapp/services/EHR.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:medicalrecordapp/services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:scan/scan.dart';
import 'package:toast/toast.dart';


class CheckRecordScreen extends StatefulWidget {
  static String id = 'check_record';

  const CheckRecordScreen({Key key}) : super(key: key);

  @override
  _CheckRecordScreenState createState() => _CheckRecordScreenState();
}

class _CheckRecordScreenState extends State<CheckRecordScreen> {
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

  List<Diagnosis> diagnosisList;

  Future<List<Diagnosis>> fetchHistory(String _uid) async {
    List<Diagnosis> _diagnosisList = [];
    final _erhRecord = EHR(uid: _uid);
    snapshot = await _erhRecord
        .historySnap();
    for (int i = 0; i < snapshot.docs.length; i++) {
      var _history = snapshot.docs[i];
      _diagnosisList.add(new Diagnosis(
        type: _history['Type'],
        date: _history['Date'],
        problem: _history['Problem'],
        verified: _history['Verified'],
        verifiedBy: _history['VerifiedBy'],
      ));
    }
    setState(() {
      // allDataFetched=true;
      diagnosisList = _diagnosisList;
    });
    return diagnosisList;
  }

  void nonAsync(String _uid) {
    fetchHistory(_uid);
  }

  @override
  void initState() {
    diagnosisList = [];
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

    final _qrDonor = new Donor(
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


            if (qrCodeType != null) {
              if (qrCodeType == 'MEDICALRECORDDIAGNOSIS') {
              uID = qrData[2];
              setState(() {
                loadingIndicator = true;
              });
              final _records = await fetchHistory(uID); // Change this for taking uID only
              setState(() {
                diagnosisList = _records;
                loadingIndicator = false;
                allDataFetched = true;
              });
              } else showMessage('The QR is not valid');
            } else showMessage('The QR is not valid');
            }
          },
        ),
        RoundedButton(
          text: 'Open Gallery',
          color: Colors.lightBlue[900],
          onPressed: () async {
            XFile image = await imagePicker.pickImage(source: ImageSource.gallery);
            if(image==null) showMessage('You did not choose a QR!');
            else {
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

              if (qrCodeType != null) {
                if (qrCodeType == 'MEDICALRECORDDIAGNOSIS') {
                uID = qrData[2];
                setState(() {
                  loadingIndicator = true;
                });
                final _records = await fetchHistory(uID); // Change this for taking uID only
                setState(() {
                  diagnosisList = _records;
                  loadingIndicator = false;
                  allDataFetched = true;
                });
                }
                else showMessage('The QR is not valid');
              }
              else showMessage('The QR is not valid');
              }
            }
          },
        ),
        ]
        )
      );
    } else {
      return Expanded(
        child: DiagnosisCardList(
          diagnosisList: diagnosisList,
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
            Text(
              'Check Record',
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
