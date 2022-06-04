import 'package:flutter/material.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/screens/donor_list_tab.dart';
import 'package:medicalrecordapp/screens/donor_map_tab.dart';
import 'package:medicalrecordapp/screens/donor_profile_tab.dart';
//import 'test.dart';

class BloodDonationScreen extends StatefulWidget {
  static String id = 'blood_donation';

  @override
  _BloodDonationScreenState createState() => _BloodDonationScreenState();
}

class _BloodDonationScreenState extends State<BloodDonationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 0,
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
                'Blood Donation',
                style: kTextStyle.copyWith(fontSize: 24),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.black54,
          bottom: TabBar(
            indicatorColor: Colors.green,
            tabs: [
              Tab(
                child: Text(
                  'My Profile',
                  style: kTextStyle.copyWith(fontSize: 14),
                ),
              ),
              Tab(
                child: Text(
                  'Donor List',
                  style: kTextStyle.copyWith(fontSize: 14),
                ),
              ),
              Tab(
                child: Text(
                  'Donor Map',
                  style: kTextStyle.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            DonorProfileTab(),
            DonorListTab(),
            DonorMapTab(),
          ],
        ),
      ),
    );
  }
}
