// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/custom_dropdown_menu.dart';
import 'package:medicalrecordapp/components/custom_text_field.dart';
import 'package:medicalrecordapp/components/rounded_button.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/models/basic_health.dart';
import 'package:medicalrecordapp/screens/qr_code_screen.dart';
import 'package:medicalrecordapp/services/EHR.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BasicHealthRecordTab extends StatefulWidget {
  const BasicHealthRecordTab({Key key}) : super(key: key);

  @override
  _BasicHealthRecordTabState createState() => _BasicHealthRecordTabState();
}

class _BasicHealthRecordTabState extends State<BasicHealthRecordTab> {
  bool loadingIndicator = false;
  final ehrDatabase = EHR(uid: Auth().getUID());
  final height = TextEditingController();
  final weight = TextEditingController();
  String sugarLevel = '';
  String rbcCount = '';
  String wbcCount = '';
  String bloodPressure = '';

  Future<void> loadCurrentRecord() async {
    final uid = Auth().getUID();
    final latestRecord = await EHR(uid: uid).getRecord();
    setState(() {
      height.text = latestRecord.height;
      weight.text = latestRecord.weight;
      sugarLevel = latestRecord.sugarLevel;
      rbcCount = latestRecord.rbc;
      wbcCount = latestRecord.wbc;
      bloodPressure = latestRecord.bp;
    });
  }

  Future<void> _submit() async {
    final _height = height.text;
    final _weight = weight.text;
    final _sugerLevel = sugarLevel;
    final _rbcCount = rbcCount;
    final _bloodPressure = bloodPressure;
    final _wbcCount = wbcCount;
    final _count = await ehrDatabase.getCount();
    basicRecord _record = basicRecord(
      height: _height,
      weight: _weight,
      sugarLevel: _sugerLevel,
      bp: _bloodPressure,
      rbc: _rbcCount,
      wbc: _wbcCount,
      count: _count,
    );
    ehrDatabase.createRecord(_record);
  }

  @override
  void initState() {
    setState(() {
      loadingIndicator = true;
    });
    loadCurrentRecord();
    setState(() {
      loadingIndicator = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ModalProgressHUD(
          color: Colors.white,
          opacity: 0.9,
          progressIndicator: kWaveLoadingIndicator,
          inAsyncCall: loadingIndicator,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CustomTextField(
                  label: "Height",
                  hint: "In Centimeters",
                  controller: height,
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Weight",
                  hint: "In Kilograms",
                  controller: weight,
                  keyboardType: TextInputType.number,
                ),
                CustomDropdownMenu(
                    label: 'Sugar Level',
                    initialValue: sugarLevel == '' ? null : sugarLevel,
                    onChanged: (value) {
                      setState(() {
                        sugarLevel = value;
                      });
                    },
                    items: const [
                      '~70-140 mg/dL',
                      '~141-200 mg/dL',
                      '>200 mg/dL',
                    ]),
                CustomDropdownMenu(
                    label: 'RBC Count',
                    initialValue: rbcCount == '' ? null : rbcCount,
                    onChanged: (value) {
                      setState(() {
                        rbcCount = value;
                      });
                    },
                    items: const [
                      'less than 4.7 mcL',
                      '~4.7-6.1 mcL',
                      'higher than 6.1 mcL'
                    ]),
                CustomDropdownMenu(
                    label: 'WBC Count',
                    initialValue: wbcCount == '' ? null : wbcCount,
                    onChanged: (value) {
                      setState(() {
                        wbcCount = value;
                      });
                    },
                    items: const [
                      '~9,000-30,000 mcL',
                      '~6,200-17,000 mcL',
                      '~5,000-10,000 mcL'
                    ]),
                CustomDropdownMenu(
                    label: 'Blood Pressure(Sys/Dias)',
                    initialValue: bloodPressure == '' ? null : bloodPressure,
                    onChanged: (value) {
                      setState(() {
                        bloodPressure = value;
                      });
                    },
                    items: const [
                      '120/80',
                      '(120-129)/(<80)',
                      '(130-139)/(80-89)',
                      '140/90',
                      '180/120',
                    ]),
                RoundedButton(
                  onPressed: () {
                    _submit();
                  },
                  text: 'Update',
                  color: Colors.lightBlue[700],
                ),
                RoundedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QrCodeScreen(
                            appBarTitle: 'Share Private Data',
                            qrCodeData: 'MedicalRecordShare_${Auth().getUID()}',),
                      ),
                    );
                  },
                  text: 'Share',
                  color: Colors.lightBlue[700],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
