// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/grid_card.dart';
import 'package:medicalrecordapp/screens/Check/check_record_screen.dart';
import 'package:medicalrecordapp/screens/record_verification_screen.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:medicalrecordapp/services/database.dart';
import 'package:medicalrecordapp/screens/Check/check_EHR_screen.dart';

class DoctorDashboardScreen extends StatefulWidget {
  static String id = 'doctor_dashboard';

  const DoctorDashboardScreen({Key key}) : super(key: key);

  @override
  _DoctorDashboardScreenState createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  bool loadingIndicator = false;
  String name = '';

  Future<void> getName() async {
    final _name = await Database(uid: Auth().getUID()).getName();
    setState(() {
      name = _name;
    });
  }

  @override
  void initState() {
    getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              'Doctor\'s Dashboard',
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
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Welcome,',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Nexa',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                    fontFamily: 'Nexa Bold',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: <Widget>[
                GridCard(
                  image: Image.asset(
                    'assets/images/medical_record_icons/qr.gif',
                    height: 60,
                  ),
                  label: 'Check Record',
                  onTap: () {
                    Navigator.pushNamed(context, CheckRecordScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/medical_record_icons/qr.gif',
                    height: 60,
                  ),
                  label: 'Verify Record',
                  onTap: () {
                    Navigator.pushNamed(context, RecordVerificationScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/medical_record_icons/qr.gif',
                    height: 60,
                  ),
                  label: 'Check EHR',
                  onTap: () {
                    Navigator.pushNamed(context, CheckEHRScreen.id);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
