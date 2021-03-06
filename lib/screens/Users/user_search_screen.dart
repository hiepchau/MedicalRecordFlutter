// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/custom_text_field.dart';
import 'package:medicalrecordapp/components/rounded_button.dart';
import 'package:medicalrecordapp/components/searched_user_info_card.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/models/blood_donor.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:medicalrecordapp/services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class UserSearchScreen extends StatefulWidget {
  static String id = 'user_search';

  const UserSearchScreen({Key key}) : super(key: key);

  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  bool loadingIndicator = false;
  TextEditingController id = TextEditingController();
  final database = Database(uid: Auth().getUID());
  QuerySnapshot snapshot;
  String name = '';
  String emergencyContact = '';
  String bloodType = '';
  String address = '';

  Future<void> printMatched(String query) async {
    QuerySnapshot _snapshot = await database.searchUserWithGovernmentID(query);
    if (_snapshot.docs.isEmpty) {
      _snapshot = await database.searchUserWithAdditionalID(query);
    }
    if (_snapshot.docs.isEmpty) {
      setState(() {
        name = '';
        emergencyContact = '';
        bloodType = '';
        address = '';
      });
    } else {
      for (int i = 0; i < _snapshot.docs.length; i++) {
        setState(() {
          snapshot = _snapshot;
          name = snapshot.docs[i]['Name'];
          emergencyContact = snapshot.docs[i]['Emergency No'];
          bloodType = snapshot.docs[i]['Blood Group'];
          address = snapshot.docs[i]['Location'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
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
            const Text(
              'Search User',
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
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: kWaveLoadingIndicator,
        inAsyncCall: loadingIndicator,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CustomTextField(
                    label: 'ID',
                    hint: 'Any ID number',
                    controller: id,
                    keyboardType: TextInputType.text,
                  ),
                  RoundedButton(
                    text: 'Search',
                    color: Colors.lightBlue[700],
                    onPressed: () async {
                      setState(() {
                        loadingIndicator = true;
                      });

                      try {
                        await printMatched(id.text);
                        setState(() {
                          loadingIndicator = false;
                        });
                      } catch (e) {
                        Toast.show(
                          e.message,
                          duration: Toast.lengthLong,
                          gravity: Toast.top,
                        );
                      }
                    },
                  ),
                  SearchedUserInfoCard(
                    searchedUser: Donor(
                      name: name,
                      contact: emergencyContact,
                      blood: bloodType,
                      location: address,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
