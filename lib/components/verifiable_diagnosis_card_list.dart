import 'package:flutter/cupertino.dart';
import 'package:medicalrecordapp/components/verifiable_diagnosis_card.dart';
import 'package:medicalrecordapp/models/diagnosis.dart';

class VerifiableDiagnosisCardList extends StatefulWidget {
  final List<Diagnosis> diagnosisList;
  const VerifiableDiagnosisCardList({Key key, this.diagnosisList}) : super(key: key);
  @override
  _VerifiableDiagnosisCardListState createState() =>
      _VerifiableDiagnosisCardListState();
}

class _VerifiableDiagnosisCardListState
    extends State<VerifiableDiagnosisCardList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.diagnosisList.length,
        itemBuilder: (context, index) {
          return VerifiableDiagnosisCard(
              diagnosis: widget.diagnosisList[index]);
        });
  }
}