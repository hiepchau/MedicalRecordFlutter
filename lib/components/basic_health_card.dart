import 'package:flutter/material.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/models/basic_health.dart';

class BasicHealthCard extends StatelessWidget {
  final basicRecord basicHealthRecord;
  final String userName;

  const BasicHealthCard({Key key, this.basicHealthRecord, this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
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
            offset: const Offset(0, 3),
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
              'Name: $userName',
              style: kTextStyle.copyWith(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              'Height: ${basicHealthRecord.height}',
              style: kTextStyle.copyWith(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              'Weight: ${basicHealthRecord.weight}',
              style: kTextStyle.copyWith(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              'RBC: ${basicHealthRecord.rbc}',
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              'WBC:${basicHealthRecord.wbc}',
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              'Sugar Level:   ${basicHealthRecord.sugarLevel}',
              style: kTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              'Blood Pressure: ${basicHealthRecord.bp}',
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
