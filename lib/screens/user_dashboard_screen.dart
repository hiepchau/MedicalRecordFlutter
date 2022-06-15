// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/grid_card.dart';
import 'package:medicalrecordapp/components/log_out_alert_dialog.dart';
import 'package:medicalrecordapp/screens/blood_donation_screen.dart';
import 'package:medicalrecordapp/screens/health_record_screen.dart';
import 'package:medicalrecordapp/screens/medical_history_screen.dart';
import 'package:medicalrecordapp/screens/Users/user_profile_screen.dart';
import 'package:medicalrecordapp/screens/Users/user_search_screen.dart';
import 'package:medicalrecordapp/screens/Doctor/doctor_mode_screen.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:medicalrecordapp/services/database.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserDashboardScreen extends StatefulWidget {
  static String id = 'user_dashboard';

  const UserDashboardScreen({Key key}) : super(key: key);

  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  bool loadingIndicator = false;

  String name = "";
  int fetch = 0;

  Future<void> userName() async {
    String uid = Auth().getUID();
    final _name = await Database(uid: uid).getName();
    setState(() {
      name = _name;
    });
  }

callNumber(BuildContext context, String number) async {
    ToastContext().init(context);
    var url = 'tel:$number';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      Toast.show(
        'Cannot launch Phone',
        duration: Toast.lengthShort,
        gravity: Toast.bottom,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (name == "" && fetch < 2) {
      userName();
      setState(() {
        fetch++;
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.logout,
                size: 30,
              ),
              color: Colors.lightBlue[900],
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => LogOutAlertDialog(
                    context: context,
                  ),
                );
              })
        ],
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
              'Dashboard',
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
                    'assets/images/medical_record_icons/profile.png',
                    height: 60,
                  ),
                  label: 'Profile',
                  onTap: () {
                    Navigator.pushNamed(context, UserProfileScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/medical_record_icons/search.png',
                    height: 60,
                  ),
                  label: 'Search User',
                  onTap: () {
                    Navigator.pushNamed(context, UserSearchScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/medical_record_icons/healthrecord.png',
                    height: 60,
                  ),
                  label: 'Health Record',
                  onTap: () {
                    Navigator.pushNamed(context, HealthRecordScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/medical_record_icons/medicalhistory.png',
                    height: 60,
                  ),
                  label: 'Medical History',
                  onTap: () {
                    Navigator.pushNamed(context, MedicalHistoryScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/medical_record_icons/blooddonation.png',
                    height: 60,
                  ),
                  label: 'Blood Donation',
                  onTap: () {
                    Navigator.pushNamed(context, BloodDonationScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/medical_record_icons/doctormode.png',
                    height: 60,
                  ),
                  label: 'Doctor Mode',
                  onTap: () {
                    Navigator.pushNamed(context, DoctorModeScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/medical_record_icons/phone.png',
                    height: 60,
                  ),
                  label: 'Call Emergency',
                  onTap: () {
                    callNumber(context, '115');
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
