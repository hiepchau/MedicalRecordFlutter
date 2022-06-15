// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicalrecordapp/components/custom_dropdown_menu.dart';
import 'package:medicalrecordapp/components/custom_text_field.dart';
import 'package:medicalrecordapp/components/rounded_button.dart';
import 'package:medicalrecordapp/models/profile_data.dart';
import 'package:medicalrecordapp/screens/user_dashboard_screen.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:medicalrecordapp/services/database.dart';

class UserProfileScreen extends StatefulWidget {
  static String id = 'user_profile';

  const UserProfileScreen({Key key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final database = Database(uid: Auth().getUID());

  final name = TextEditingController();
  String gender = 'Male';
  final age = TextEditingController();
  String blood = 'A+';
  final contact = TextEditingController();
  final emergency = TextEditingController();
  final govtID = TextEditingController();
  final otherID = TextEditingController();
  final location = TextEditingController();
  Timestamp selectedDate = Timestamp.now();
  final TextEditingController _date = TextEditingController();

  final dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.toDate(),
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate.toDate()) {
      setState(() {
        selectedDate = Timestamp.fromDate(picked);
        _date.value = TextEditingValue(text: dateFormat.format(picked));
      });
    }
  }

  Future<void> _submit() async {
    final _name = name.text;
    final _age = age.text;
    final _contact = contact.text;
    final _emergency = emergency.text;
    final _gender = gender;
    final _bloodGroup = blood;
    final _govtID = govtID.text;
    final _otherID = otherID.text;
    final _location = location.text;
    final _dob = selectedDate;
    ProfileData person = ProfileData(
      name: _name,
      age: _age,
      contact: _contact,
      emergency: _emergency,
      gender: _gender,
      blood: _bloodGroup,
      dob: _dob,
      govtID: _govtID,
      otherID: _otherID,
      location: _location,
      donorStatus: await database.getStatus(),
    );
    await database.createProfile(person);
    // ignore: use_build_context_synchronously
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const UserDashboardScreen()));
  }

  int count = 0;
  ProfileData person;
  Future<void> loadCurrentData() async {
    String uid = Auth().getUID();
    final data = await Database(uid: uid).getData(uid);
    setState(() {
      person = data;
      name.text = person.name;
      age.text = person.age;
      contact.text = person.contact;
      emergency.text = person.emergency;
      gender = person.gender;
      blood = person.blood;
      govtID.text = person.govtID;
      otherID.text = person.otherID;
      location.text = person.location;
      selectedDate = person.dob;
      _date.text = dateFormat.format(selectedDate.toDate());
    });
  }

  @override
  void initState() {
    loadCurrentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Profile',
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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomTextField(
                label: "Name",
                hint: "Full Name",
                controller: name,
                keyboardType: TextInputType.text,
              ),
              CustomTextField(
                label: "Age",
                hint: "Age in Years",
                controller: age,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                label: "Phone Number",
                hint: "Phone",
                controller: contact,
                keyboardType: TextInputType.phone,
              ),
              CustomTextField(
                label: "Emergency Contact",
                hint: "Emergency Contact Number",
                controller: emergency,
                keyboardType: TextInputType.phone,
              ),
              CustomDropdownMenu(
                label: 'Gender',
                initialValue: gender == '' ? gender = 'Male' : gender ,
                items: const ['Male', 'Female'],
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
              CustomDropdownMenu(
                label: "Blood Group",
                initialValue: blood == '' ? blood = 'A+' : blood,
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
                onChanged: (value) {
                  setState(() {
                    blood = value;
                  });
                },
              ),
              CustomTextField(
                label: "Address",
                hint: "Street Address",
                controller: location,
                keyboardType: TextInputType.streetAddress,
              ),
              CustomTextField(
                label: 'Government ID',
                hint: 'National ID/ Birth Certificate ID',
                controller: govtID,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                label: 'Professional ID',
                hint: 'Office/Student ID',
                controller: otherID,
                keyboardType: TextInputType.number,
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextField(
                    label: "Birth Date",
                    hint: "Select your Date of Birth",
                    controller: _date,
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ),
              RoundedButton(
                onPressed: _submit,
                text: 'Update',
                color: Colors.lightBlue[700],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Geolocator() {}
}
