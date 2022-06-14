import 'package:flutter/material.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/models/diagnosis.dart';

class DiagnosisCard extends StatelessWidget {
  final Diagnosis diagnosis;

  const DiagnosisCard({Key key, this.diagnosis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color:
            diagnosis.verified ? Colors.lightBlue[100] : Colors.lightBlue[50],
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              diagnosis.type,
              style: kTextStyle.copyWith(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              diagnosis.problem,
              style: kTextStyle.copyWith(
                fontSize: 36,
                color: Colors.lightBlue[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              diagnosis.date,
              style: kTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              'Verified By: ${diagnosis.verified ? diagnosis.verifiedBy : 'Not yet verified'}',
              style: kTextStyle.copyWith(
                fontSize: 16,
                color: Colors.black45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
