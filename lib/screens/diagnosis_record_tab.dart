// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/diagnosis_card_list.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/models/diagnosis.dart';
import 'package:medicalrecordapp/services/EHR.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DiagnosisRecordTab extends StatefulWidget {
  const DiagnosisRecordTab({Key key}) : super(key: key);

  @override
  _DiagnosisRecordTabState createState() => _DiagnosisRecordTabState();
}

class _DiagnosisRecordTabState extends State<DiagnosisRecordTab> {
  bool loadingIndicator = true;

  final erhRecord = EHR(uid: Auth().getUID());
  CollectionReference refference;
  QuerySnapshot snapshot;

  List<Diagnosis> diagnosisList;

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
    diagnosisList = [];
    nonAsync();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //fetchHistory();
    loadingIndicator = false;
    return ModalProgressHUD(
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
              child: DiagnosisCardList(
                diagnosisList: diagnosisList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
