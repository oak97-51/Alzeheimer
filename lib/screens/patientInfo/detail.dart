import 'dart:convert';

import 'package:Alzeheimer/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Alzeheimer/data/model_patientbyid.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  // final PatientModel patientModel;
  final PatientByIDModel patientByIDModel;
  final String paramId;
  @override
  _DetailState createState() => _DetailState();

   Detail({
    Key key,
    this.paramId,
    this.patientByIDModel,
    // this.patientModel,
  }) : super(key: key);
}

class _DetailState extends State<Detail> {
  //Future<List<User>> patient;
  // PatientModel patientModel;
  PatientByIDModel patientByIDModel;
  String paramId;

  List<PatientByIDModel> patientByIDModels = List();

  @override
  void initState() {
    super.initState();
    // user = fetchUser();
    paramId = widget.paramId;
    patientByIDModel = widget.patientByIDModel;
    print("pageload");
    readPatient();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: MyStyle().txt16Bold('ประวัติผู้ป่วย'),
        backgroundColor: MyStyle().mainColor,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text('ID : $paramId') ,
              // child: Image(image: NetworkImage('${patientModels[index].img}'),)
              // child: Image.network('${patientModel.img}'),
            ),
            Container(
              // child: Image.network('${widget.userId.profile}'),
            ),
            Container(
              // child: Text('${widget.userId.title}'),
            ),
          ],
        ),
      ),
      
    );
  }

  Future<Null> readPatient() async {
    String url =
        'http://restaurant2019.com/htdocs/fetch_patient_byID.php?isAdd=true&id=$paramId';
    //  print(url);
    Response response = await Dio().get(url); // read data from api
    // print('res ==> $response');
    var result = json.decode(response.data); // ถอดรหัสให้เป็น ภาษาไทย
    print('result = $result');

    for (var map in result) {
      patientByIDModel = PatientByIDModel.fromMap(map);
      print('pname = ${patientByIDModel.lastName}');
      // if (productModel.pname.isEmpty) {
      // } else {} 

      setState(() {
        // productModel = ProductModel.fromMap(map);
        patientByIDModels.add(patientByIDModel);
        // reccount = patientModels.length.toString();
      });
      // print("data");
    }

    //print('http://restaurant2019.com/htdocs/photo/${patientModels[index].patientId}.jpg');
  }
}