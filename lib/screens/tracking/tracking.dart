import 'package:Alzeheimer/screens/tracking/trackingmap.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:dio/dio.dart';
// import 'package:toast/toast.dart';
import 'package:Alzeheimer/data/model_tracking.dart';
// import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:Alzeheimer/utility/my_style.dart';

class Tracking extends StatefulWidget {
  final TrackingModel trackingModel;
  final String paramId;
  Tracking({Key key, this.trackingModel, this.paramId}) : super(key: key);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  TrackingModel trackingModel;
  List<TrackingModel> trackingModels = List();
  String reccount = "0";

  Position currentLocation;
  LatLng center;
  String paramId;

  @override
  void initState() {
    super.initState();
    paramId = widget.paramId;
    trackingModel = widget.trackingModel;
    readTracking(paramId);
  }

  Future<Null> readTracking(id) async {
    // print('ID : $id');
    String url =
        'http://restaurant2019.com/htdocs/fetch_tracking.php?isAdd=true&id=$id';
    // print(url);
    Response response = await Dio().get(url); // read data from api
    // print('res ==> $response');
    var result = json.decode(response.data); // ถอดรหัสให้เป็น ภาษาไทย
    print('result = $result');
    trackingModels.clear();
    for (var map in result) {
      trackingModel = TrackingModel.fromMap(map);
      // print('pname = ${productModel.pname}');
      // if (productModel.pname.isEmpty) {
      // } else {}

      setState(() {
        // productModel = ProductModel.fromMap(map);
        trackingModels.add(trackingModel);
        reccount = trackingModels.length.toString();
      });
      // print("data");
    }
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

          // RaisedButton(
          //   onPressed: () {
          //     MapsLauncher.launchCoordinates(currentLocation.latitude,
          //         currentLocation.longitude, 'ตำแหน่งปัจจุบัน');
          //   },
          //   child: Text('ตำแหน่งปัจจุบัน'),
          // ),

          RaisedButton(
            onPressed: () {
              // MapsLauncher.launchCoordinates(currentLocation.latitude,
              //     currentLocation.longitude, 'ตำแหน่งปัจจุบัน');

              MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => TrackingMap(
                        paramId: paramId,
                      )); //วิธีเชื่อมหน้า
              Navigator.push(context, route);
            },
            child: Text('แผนที่'),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: trackingModels.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.all(8.0),
                // height: MediaQuery.of(context).size.height / 1.50,
                // width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.lightBlueAccent[50],
                  elevation: 8,
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        MyStyle()
                            .txt16BoldB('${trackingModels[index].cdatetime} '),
                      ],
                    ),
                    onTap: () {
                      var vlat = double.tryParse(trackingModels[index].lat);
                      var vlng = double.tryParse(trackingModels[index].lng);
                      MapsLauncher.launchCoordinates(
                          vlat, vlng, 'ติดตามตำแหน่งปัจจุบัน');

                      // MaterialPageRoute route = MaterialPageRoute(
                      //     builder: (value) => Tracking(
                      //           paramId: trackingModels[index].patientId,
                      //         )); //วิธีเชื่อมหน้า
                      // Navigator.push(context, route);

                      //print('param : ${carModels[index].carplate}');
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          readTracking(paramId);
        },
        child: Icon(Icons.refresh),
      ),
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
