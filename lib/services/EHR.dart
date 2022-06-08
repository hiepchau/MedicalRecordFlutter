// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicalrecordapp/models/basic_health.dart';
import 'package:medicalrecordapp/models/diagnosis.dart';
import 'package:medicalrecordapp/services/api_path.dart';
import 'package:medicalrecordapp/services/authenticate.dart';

class EHR {
  final String uid;
  EHR({@required this.uid});
  CollectionReference user =
      FirebaseFirestore.instance.collection('health_record');

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    var snapshot = await user.doc(uid).get();
    if (snapshot.exists) {
      reference.update(data);
    } else {
      reference.set(data);
    }
  }

  Future<void> createRecord(basicRecord record) async {
    await _setData(path: APIPath.ehr(uid), data: record.toMap());
  }

  Future<basicRecord> getRecord() async {
    var snapshot = await user.doc(uid).get();
    if (snapshot.exists) {
      return basicRecord(
        height: snapshot['Height'] ??'',
        weight: snapshot['Weight'] ?? '',
        sugarLevel: snapshot['Sugar Level'] ?? '~70-140 mg/dL',
        bp: snapshot['Blood Pressure'] ?? '120/80',
        rbc: snapshot['RBC Count'] ?? '~4.7-6.1 mcL',
        wbc: snapshot['WBC Count'] ?? '~9,000-30,000 mcL',
        count: snapshot['Count'],
      );
    } else {
      return basicRecord(
        height: '',
        weight: '',
        sugarLevel: '~70-140 mg/dL',
        rbc: '~4.7-6.1 mcL',
        wbc: '~9,000-30,000 mcL',
        bp: '120/80',
        count: 0,
      );
    }
  }

  Future<int> getCount() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('health_record')
        .doc(uid)
        .get();
    if (snapshot.exists) {
      return snapshot.data()['Count'] ?? 0;
    } else {
      return 0;
    }
  }

  Future<void> updateHistoryCount() async {
    int count = await getCount();
    return user
        .doc(uid)
        .update({'Count': count + 1});
  }

  // History Data Base From Here

  CollectionReference diagnosisRef = FirebaseFirestore.instance
      .collection('health_record')
      .doc(Auth().getUID())
      .collection('history');

  Future<void> _setDiagnosis({String path, Map<String, dynamic> data}) async {
    final referrence = FirebaseFirestore.instance.doc(path);
    await referrence.set(data);
  }

  Future<void> createDiagnosis(Diagnosis diagnosis) async {
    int currentID;
    await updateHistoryCount();
    currentID = await getCount();
    diagnosis.id = currentID;
    await _setDiagnosis(
        path: APIPath.diagnosis(uid, currentID.toString()),
        data: diagnosis.toMap());
  }

  Future<QuerySnapshot> historySnap() async {
    return await FirebaseFirestore.instance
        .collection('health_record')
        .doc(uid)
        .collection('history')
        .get();
  }
}
