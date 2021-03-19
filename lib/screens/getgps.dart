import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class Getgps extends StatefulWidget {
  Getgps({Key key}) : super(key: key);

  @override
  _GetgpsState createState() => _GetgpsState();
}

class _GetgpsState extends State<Getgps> {
  LatLng center;
  Position currentLocation;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตำแหน่งปัจจุบัน'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text('ตำแหน่งปัจจุบัน : $_center'),
          // SizedBox(height: 32),
          RaisedButton(
            onPressed: () {
              MapsLauncher.launchCoordinates(currentLocation.latitude,
                  currentLocation.longitude, 'ตำแหน่งปัจจุบัน');
              MapsLauncher.launchQuery('โรงพยาบาล');
            },
            child: Text('ค้นหาโรงพยาบาลที่ใกล้ที่สุด'),
          ),
        ],
      )),
    );
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });

    // print('center $_center');
  }
}
