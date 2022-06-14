import 'package:flutter/material.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/models/blood_donor.dart';
import 'package:medicalrecordapp/models/diagnosis.dart';

class UserDiagnosisCard extends StatelessWidget {
  final Donor targetUser;
  final Diagnosis targetDiagnosis;

  const UserDiagnosisCard({
    Key key,
    this.targetUser,
    this.targetDiagnosis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${targetUser.name}\'s Diagnosis',
              style: kTextStyle.copyWith(
                fontSize: 28,
                color: Colors.lightBlue[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Name: ${targetUser.name}',
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Blood Group: ${targetUser.blood}',
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Contact: ${targetUser.contact}',
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Location: ${targetUser.location}',
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Problem Type: ${targetDiagnosis.type}',
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Description: ${targetDiagnosis.problem}',
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Date: ${targetDiagnosis.date}',
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
