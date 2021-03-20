import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:dio/dio.dart';
import 'package:toast/toast.dart';
import 'dart:async';

class Getgps2 extends StatefulWidget {
  final String paramId;
  Getgps2({Key key, this.paramId}) : super(key: key);

  @override
  _Getgps2State createState() => _Getgps2State();
}

class _Getgps2State extends State<Getgps2> {
  Position currentLocation;
  LatLng center;
  String paramId;

  @override
  void initState() {
    super.initState();
    paramId = widget.paramId;
    getUserLocation();
  }

  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<Null> insertData(
    String patientID,
    String lat,
    String lng,
    DateTime cdatetime,
  ) async {
    String url =
        'http://restaurant2019.com/htdocs/insert_tracking.php?isAdd=true&patient_id=$patientID&lat=$lat&lng=$lng&cdatetime=$cdatetime';

    await Dio().get(url).then((value) {});
    Toast.show("บันทึกตำแหน่งปัจจุบันเรียบร้อย", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    print(url);
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

          RaisedButton(
            onPressed: () {
              Timer.periodic(new Duration(seconds: 30), (timer) {
                //  debugPrint(timer.tick.toString());
                saveUserLocation();
              });
            },
            child: Text('บันทึกตำแหน่งปัจจุบัน'),
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

  saveUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      center = LatLng(currentLocation.latitude, currentLocation.longitude);
      // insertData(patientID, lat, lng, cdatetime)
      insertData(paramId, currentLocation.latitude.toString(),
          currentLocation.longitude.toString(), DateTime.now());
    });

    // print('center $_center');
  }
}
