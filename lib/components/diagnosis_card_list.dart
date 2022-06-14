// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:medicalrecordapp/components/diagnosis_card.dart';
import 'package:medicalrecordapp/models/diagnosis.dart';

class DiagnosisCardList extends StatefulWidget {
  final List<Diagnosis> diagnosisList;

  const DiagnosisCardList({Key key, this.diagnosisList}) : super(key: key);

  @override
  _DiagnosisCardListState createState() => _DiagnosisCardListState();
}

class _DiagnosisCardListState extends State<DiagnosisCardList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.diagnosisList.length,
        itemBuilder: (context, index) {
          return DiagnosisCard(diagnosis: widget.diagnosisList[index]);
        });
  }
}
