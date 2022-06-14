// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/alert_dialog_form.dart';
import 'package:medicalrecordapp/components/verifiable_diagnosis_card_list.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/models/diagnosis.dart';
import 'package:medicalrecordapp/services/EHR.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MedicalHistoryScreen extends StatefulWidget {
  static String id = 'medical_history';

  const MedicalHistoryScreen({Key key}) : super(key: key);

  @override
  _MedicalHistoryScreenState createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  bool loadingIndicator = false;
  List<Diagnosis> diagnosisList;
  final erhRecord = EHR(uid: Auth().getUID());
  CollectionReference reference;
  QuerySnapshot snapshot;

  Future<List<Diagnosis>> fetchHistory() async {
    List<Diagnosis> _diagnosisList = [];
    snapshot = await erhRecord.historySnap();
    for (int i = 0; i < snapshot.docs.length; i++) {
      var _history = snapshot.docs[i];
      _diagnosisList.add(Diagnosis(
        type: _history['Type'],
        date: _history['Date'],
        problem: _history['Problem'],
        verified: _history['Verified'],
        verifiedBy: _history['VerifiedBy'],
        id: _history['ID'],
      ));
    }
    setState(() {
      diagnosisList = _diagnosisList;
    });
    return diagnosisList;
  }

  void nonAsync() {
    fetchHistory();
  }

  @override
  void initState() {
    setState(() {
      loadingIndicator = true;
    });
    diagnosisList = [];
    nonAsync();
    setState(() {
      loadingIndicator = false;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
              'Medical History',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[900],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialogForm(
              context: context,
            ),
          );
          setState(() {});
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
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
              Expanded(
                child: VerifiableDiagnosisCardList(
                  diagnosisList: diagnosisList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
