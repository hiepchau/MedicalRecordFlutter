import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medicalrecordapp/constants.dart';
import 'package:medicalrecordapp/components/list_info_card.dart';
import 'package:medicalrecordapp/models/profile_data.dart';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:medicalrecordapp/services/database.dart';

class DonorProfileTab extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<DonorProfileTab> {
  ProfileData profile= new ProfileData(contact: "", blood: "", name: "", age: "", dob: Timestamp.now(), gender: "", govtID: "");
  int fetch = 0;
  bool donorStatus = true;
  Position position;
  Future<void> getInfo() async {
    String uid = Auth().getUID();
    final _profile = await Database(uid: uid).getData(uid);
    setState(() {
      profile = _profile;
      donorStatus = profile.donorStatus;
    });
  }

  Future<void> updateStatus() async {
    String uid = Auth().getUID();
    await Database(uid: uid).updateDonorStatus(donorStatus);
    if (donorStatus) {
      final _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      await Database(uid: uid).updateLocation(
          _position.latitude.toString(), _position.longitude.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (fetch < 2) {
      getInfo();
      setState(() {
        fetch++;
      });
    }
    if (profile.name==""&&fetch<2){
      donorStatus=false;
      child = Scaffold(
        body: SpinKitWave(
          color: Colors.lightBlue[700],
        ),
      );
    }
    else if(profile.name==""){
      donorStatus=false;
      child = Scaffold(
          body: Container(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Center(
                child: Text(
                  'Your profile is not exist!',
                  style: kTextStyle,
                  textAlign: TextAlign.center,
                )
                ),
                Center(
                child: Text(
                  'Please complete your profile',
                  style: kTextStyle,
                  textAlign: TextAlign.center,
                )
                )
              ],
          ),         
          ),
      );
    }
    else if(profile.name!=""){
      child = ListView(
      children: <Widget>[
        ListInfoCard(
          title: 'Name',
          description: profile.name,
        ),
        ListInfoCard(
          title: 'Contact',
          description: profile.contact,
        ),
        ListInfoCard(
          title: 'Blood Group',
          description: profile.blood,
        ),
        ListInfoCard(
          title: 'Current Location',
          description: profile.location,
        ),
        ListInfoCard(
          title: 'Last Donation',
          description: 'November 23, 2020',
        ),
        ListInfoCard(
          title: 'Gender',
          description: profile.gender,
        ),
        ListInfoCard(
          title: 'Age',
          description: profile.age,
        ),
        GestureDetector(
          onTap: () {},
          child: Card(
            child: SwitchListTile(
              value: donorStatus,
              activeColor: Colors.lightBlue,
              title: Text(
                'Donor Status',
                style: kTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),             
              onChanged: (bool value) {
                setState(() {
                  donorStatus = value;
                  updateStatus();
                });
              },
            ),
          ),
        ),
      ],
    );     
    }  
    return new Container(child: child);
  }
}
