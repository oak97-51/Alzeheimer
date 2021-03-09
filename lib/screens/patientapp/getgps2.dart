import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class Getgps2 extends StatefulWidget {
  Getgps2({Key key}) : super(key: key);

  @override
  _Getgps2State createState() => _Getgps2State();
}

class _Getgps2State extends State<Getgps2> {
  Position currentLocation;
  LatLng _center;

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
            },
            child: Text('ตำแหน่งปัจจุบัน'),
          ),
        ],
      )),
    );
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });

    // print('center $_center');
  }
}
