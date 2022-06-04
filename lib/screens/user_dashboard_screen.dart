import 'package:flutter/material.dart';
import 'package:medicalrecordapp/components/grid_card.dart';
import 'package:medicalrecordapp/components/log_out_alert_dialog.dart';
import 'package:medicalrecordapp/screens/blood_donation_screen.dart';
import 'package:medicalrecordapp/screens/health_record_screen.dart';
import 'package:medicalrecordapp/screens/medical_history_screen.dart';
import 'package:medicalrecordapp/screens/user_profile_screen.dart';
import 'package:medicalrecordapp/screens/user_search_screen.dart';
import 'package:medicalrecordapp/screens/doctor_mode_screen.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:medicalrecordapp/services/database.dart';

class UserDashboardScreen extends StatefulWidget {
  static String id = 'user_dashboard';

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
              icon: Icon(
                Icons.logout,
                size: 30,
              ),
              color: Colors.green[900],
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
              child: Container(
                height: 40.0,
                child: Image.asset(
                  'assets/images/lifeline_logo.png',
                ),
              ),
            ),
            Text(
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
        padding: EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Welcome,',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Nexa',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Nexa Bold',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: <Widget>[
                GridCard(
                  image: Image.asset(
                    'assets/images/lifeline_icons/profie_icon.png',
                    height: 60,
                  ),
                  label: 'Profile',
                  onTap: () {
                    Navigator.pushNamed(context, UserProfileScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/lifeline_icons/search_user_icon.png',
                    height: 60,
                  ),
                  label: 'Search User',
                  onTap: () {
                    Navigator.pushNamed(context, UserSearchScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/lifeline_icons/health_record_icon.png',
                    height: 60,
                  ),
                  label: 'Health Record',
                  onTap: () {
                    Navigator.pushNamed(context, HealthRecordScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/lifeline_icons/medical_history_icon.png',
                    height: 60,
                  ),
                  label: 'Medical History',
                  onTap: () {
                    Navigator.pushNamed(context, MedicalHistoryScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/lifeline_icons/blood_donation_icon.png',
                    height: 60,
                  ),
                  label: 'Blood Donation',
                  onTap: () {
                    Navigator.pushNamed(context, BloodDonationScreen.id);
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/lifeline_icons/doctor_mode_icon.png',
                    height: 60,
                  ),
                  label: 'Doctor Mode',
                  onTap: () {
                    Navigator.pushNamed(context, DoctorModeScreen.id);
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
