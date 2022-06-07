import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicalrecordapp/constants.dart';
import 'dart:async';
import 'package:medicalrecordapp/services/authenticate.dart';
import 'package:medicalrecordapp/services/database.dart';
import 'package:medicalrecordapp/models/blood_donor.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DonorMapTab extends StatefulWidget {
  @override
  _DonorMapTabState createState() => _DonorMapTabState();
}

class _DonorMapTabState extends State<DonorMapTab> {
  final GlobalKey scaffoldKey = GlobalKey();

  bool loadingIndicator = true;

  final database = Database(uid: Auth().getUID());
  CollectionReference databaseReference;
  QuerySnapshot snapshot;

  String blood;

  List<Donor> donors = [];


  Future<void> fetchDonorList(String str) async {
    snapshot = await database.bloodDonorList(str);
  }

  List<Donor> list = [];

  Completer _controller = Completer();
  Map<MarkerId, Marker> markers = {};
  List listMarkerIds = [];
  static LatLng initpos;
  LocationPermission permission;

  void getUserLocation() async {
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.deniedForever){
        return Future.error('Location is not Available');
      }
    } else if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      setState(() {
        initpos = LatLng(position.latitude, position.longitude);
        loadingIndicator=false;
      });
    } else {
      throw Exception('Error');
    }
    
  }

  @override
  void initState() {
    databaseReference = database.users;
    getUserLocation();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  void createList(String blood) async {

    await fetchDonorList(blood);

    for (int i = 0; i < snapshot.docs.length; i++) {
      list.add(
        Donor(
            blood: snapshot.docs[i]['Blood Group'].toString(),
            contact: snapshot.docs[i]['Contact No'].toString(),
            latitute: snapshot.docs[i]['Latitute'].toString() ?? '',
            longitude: snapshot.docs[i]['Longitude'].toString() ?? '',
            location: snapshot.docs[i]['Location'].toString(),
            name: snapshot.docs[i]['Name'].toString()),
      );
    }
    
  }

  @override
  Widget build(BuildContext contxet) {
    setState(() {});
    createList("A+");
    createList("A-");
    createList("B+");
    createList("B-");
    createList("AB+");
    createList("AB-");
    createList("O+");
    createList("O-");
    setState(() {});
    return 
        Scaffold(
            key: scaffoldKey,
            body: Container(
              child: map(),
        ));
  }

  Widget map() {
    if(loadingIndicator==false)
    return  Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initpos,
          zoom: 14.00,
        ),
        onTap: (_) {},
        mapType: MapType.normal,
        markers: Set.of(markers.values),
        onMapCreated: (GoogleMapController controler) {
          _controller.complete(controler);

          MarkerId selfid = MarkerId("me");
          listMarkerIds.add(selfid);

          Marker self = Marker(
              markerId: selfid,
              position: LatLng(initpos.latitude, initpos.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueViolet),
              infoWindow: InfoWindow(title: "you", onTap: () {}, snippet: " "));

          setState(() {
            markers[selfid] = self;
          });

          for (int i = 0; i < list.length; i++) {
            MarkerId markerId1 = MarkerId(i.toString());

            listMarkerIds.add(markerId1);

            Marker marker1 = Marker(
                markerId: markerId1,
                position: LatLng(double.parse(list[i].latitute),
                    double.parse(list[i].longitude)),
                icon: (list[i].latitute == initpos.latitude &&
                        list[i].longitude == initpos.longitude)
                    ? BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueViolet)
                    : BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueCyan),

                infoWindow: InfoWindow(
                    title: list[i].name,
                    onTap: () {
                      var bottomSheetController =
                          Scaffold.of(scaffoldKey.currentContext)
                              .showBottomSheet((context) => Container(
                                    child: getBottomSheet(list[i]),
                                    height: 250,
                                    color: Colors.transparent,
                                  ));
                    },
                    snippet: list[i].blood));

            setState(() {
              markers[markerId1] = marker1;
            });
          }
          //});
        },
      ),
    );  
    else 
      return ModalProgressHUD(
        inAsyncCall: loadingIndicator,
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: kWaveLoadingIndicator,
        child: Container());
    
  }


  Widget getBottomSheet(Donor donor) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 32),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: (donor.latitute == initpos.latitude &&
                        donor.longitude == initpos.longitude)
                    ? Colors.black45
                    : Colors.redAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donor.name,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(donor.blood,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(donor.location,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.map,
                    color: Colors.lightBlue,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text((donor.latitute).toString() +
                      "," +
                      (donor.longitude).toString())
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.call,
                    color: Colors.lightBlue,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(donor.contact)
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
                child: Icon(Icons.navigation), onPressed: () {}),
          ),
        )
      ],
    );
  }
}
