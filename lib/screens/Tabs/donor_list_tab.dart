// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/custom_dropdown_menu.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/components/donor_info_card.dart';
import 'package:medicalrecordapp/models/blood_donor.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:medicalrecordapp/services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DonorListTab extends StatefulWidget {
  const DonorListTab({Key key}) : super(key: key);

  @override
  DonorListTabState createState() => DonorListTabState();
}

class DonorListTabState extends State<DonorListTab> {
  bool loading = false;

  final database = Database(uid: Auth().getUID());
  CollectionReference databaseReference;
  QuerySnapshot snapshot;
  String blood;

  List<Donor> donors;

  Future<void> fetchDonorList(String str) async {
    snapshot = await database.donorList(str);
  }

  @override
  void initState() {
    donors = [];

    databaseReference = database.users;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      opacity: 0.9,
      progressIndicator: kWaveLoadingIndicator,
      inAsyncCall: loading,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomDropdownMenu(
              label: "Blood Group",
              items: const [
                'A+',
                'A-',
                'B+',
                'B-',
                'AB+',
                'AB-',
                'O+',
                'O-',
              ],
              onChanged: (value) async {
                setState(() {
                  blood = value;
                });

                setState(() {
                  blood = value;
                  loading = true;
                });

                await fetchDonorList(blood);
                donors = [];
                for (int i = 0; i < snapshot.docs.length; i++) {
                  donors.add(
                    Donor(
                        blood: snapshot.docs[i]['Blood Group'],
                        contact: snapshot.docs[i]['Contact No'],
                        latitute: snapshot.docs[i]['Latitute'] ?? '',
                        longitude: snapshot.docs[i]['Longitude'] ?? '',
                        location: snapshot.docs[i]['Location'],
                        name: snapshot.docs[i]['Name']),
                  );
                }

                setState(() {
                  loading = false;
                });
              },
            ),
            Expanded(
              child: DynamicList(
                donorList: donors,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List getList() {
    return donors;
  }
}

class DynamicList extends StatefulWidget {
  final List<Donor> donorList;
  const DynamicList({Key key, this.donorList}) : super(key: key);
  @override
  _DynamicListState createState() => _DynamicListState();
}

class _DynamicListState extends State<DynamicList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.donorList.length,
        itemBuilder: (context, index) {
          return DonorInfoCard(donor: widget.donorList[index]);
        });
  }
}
