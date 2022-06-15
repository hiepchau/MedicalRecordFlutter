// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/screens/Tabs/basic_health_record_tab.dart';
import 'package:medicalrecordapp/screens/diagnosis_record_tab.dart';

class HealthRecordScreen extends StatefulWidget {
  static String id = 'health_record';

  const HealthRecordScreen({Key key}) : super(key: key);

  @override
  _HealthRecordScreenState createState() => _HealthRecordScreenState();
}

class _HealthRecordScreenState extends State<HealthRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
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
              Text(
                'Health Record',
                style: kTextStyle.copyWith(fontSize: 24),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.black54,
          bottom: TabBar(
            indicatorColor: Colors.lightBlue,
            tabs: [
              Tab(
                child: Text(
                  'Basic',
                  style: kTextStyle.copyWith(fontSize: 14),
                ),
              ),
              Tab(
                child: Text(
                  'Diagnosis',
                  style: kTextStyle.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            BasicHealthRecordTab(),
            DiagnosisRecordTab(),
          ],
        ),
      ),
    );
  }
}
