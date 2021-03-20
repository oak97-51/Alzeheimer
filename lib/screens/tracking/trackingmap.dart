import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:maps_launcher/maps_launcher.dart';
import 'package:dio/dio.dart';
// import 'package:toast/toast.dart';
import 'package:Alzeheimer/data/model_tracking.dart';
// import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class TrackingMap extends StatefulWidget {
  final TrackingModel trackingModel;
  final String paramId;

  TrackingMap({Key key, this.trackingModel, this.paramId}) : super(key: key);

  @override
  _TrackingMapState createState() => _TrackingMapState();
}

class _TrackingMapState extends State<TrackingMap> {
  TrackingModel trackingModel;
  List<TrackingModel> trackingModels = List();
  String reccount = "0";

  Position currentLocation;
  LatLng center;
  String paramId;

  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;

  @override
  void initState() {
    super.initState();
    paramId = widget.paramId;
    trackingModel = widget.trackingModel;
    // readTracking(paramId);
  }

  void addPoly() {
    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.red,
      width: 5,
      points: _createPoints(),
    );

    setState(() {
      _mapPolylines[polylineId] = polyline;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ตำแหน่งปัจจุบัน'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: addPoly)
          ],
        ),
        body: GoogleMap(
          initialCameraPosition:
              const CameraPosition(target: LatLng(0, 0), zoom: 4.0),
          polylines: Set<Polyline>.of(_mapPolylines.values),
        ));
  }

  List<LatLng> _createPoints() {
    final List<LatLng> points = <LatLng>[];
    // points.add(LatLng(1.875249, 0.845140));
    // points.add(LatLng(4.851221, 1.715736));
    // points.add(LatLng(8.196142, 2.094979));
    // points.add(LatLng(12.196142, 3.094979));
    // points.add(LatLng(16.196142, 4.094979));
    // points.add(LatLng(20.196142, 5.094979));

    points.add(LatLng(13.6419987, 100.4445211));
    points.add(LatLng(13.6450372, 100.4441479));
    points.add(LatLng(13.6484136, 100.4438063));
    points.add(LatLng(13.6487761, 100.4438035));
    points.add(LatLng(13.6487767, 100.4438052));
    points.add(LatLng(13.6487773, 100.443807));
    points.add(LatLng(13.648778, 100.4438087));
    points.add(LatLng(13.6487791, 100.4438111));
    points.add(LatLng(13.6487806, 100.4438139));
    points.add(LatLng(13.6487816, 100.4438157));
    points.add(LatLng(13.6487829, 100.4438162));
    points.add(LatLng(13.648784, 100.4438167));
    points.add(LatLng(13.6488135, 100.4437913));
    points.add(LatLng(13.6488139, 100.4437886));
    points.add(LatLng(13.6488141, 100.443788));
    points.add(LatLng(13.6488142, 100.4437869));
    points.add(LatLng(13.6488146, 100.4437874));
    points.add(LatLng(13.6488153, 100.4437886));

    return points;
  }
}
