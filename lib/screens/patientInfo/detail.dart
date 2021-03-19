import 'dart:convert';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Alzeheimer/data/model_patientbyid.dart';
import 'package:Alzeheimer/data/model_patientbyid2.dart';
// import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  // final PatientModel patientModel;
  final PatientByIDModel2 patientByIDModel2;
  final String paramId;
  @override
  _DetailState createState() => _DetailState();

  Detail({
    Key key,
    this.paramId,
    this.patientByIDModel2,
    // this.patientModel,
  }) : super(key: key);
}

class _DetailState extends State<Detail> {
  //Future<List<User>> patient;
  // PatientModel patientModel;
  PatientByIDModel2 patientByIDModel2;
  String paramId;

  List<PatientByIDModel2> patientByIDModels2 = List();

  @override
  void initState() {
    super.initState();
    // user = fetchUser();
    paramId = widget.paramId;
    patientByIDModel2 = widget.patientByIDModel2;
    print("pageload");
    readPatient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
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
            Expanded(
              child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            margin: EdgeInsets.all(10),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network('${patientByIDModel2.img}')),
                          )
                          // Text('เลขที่บัตรประชาชน : ${patientByIDModel2.identity}'),
                        ]),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ชื่อ-นามสกุล : ${patientByIDModel2.firstName}  ${patientByIDModel2.lastName}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     เลขที่บัตรประชาชน : ${patientByIDModel2.identity}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     วันเดือนปีเกิด : ${patientByIDModel2.dateOfBirth}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     เพศ : ${patientByIDModel2.gender}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     อายุ : ${patientByIDModel2.age}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     อาชีพ : ${patientByIDModel2.career}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     สัญชาติ : ${patientByIDModel2.nationality}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ศาสนา : ${patientByIDModel2.religion}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     หมู่เลือด : ${patientByIDModel2.bloodGroup}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ที่อยู่ : ${patientByIDModel2.address}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     เบอร์โทรศัพท์ : ${patientByIDModel2.tel}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ชื่อ-นามสกุล บิดา : ${patientByIDModel2.nameOfDad}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ชื่อ-นามสกุล มารดา : ${patientByIDModel2.nameOfMom}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ชื่อผู้ติดต่อได้กรณีฉุกเฉิน : ${patientByIDModel2.nameEmergency}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ที่อยู่ผู้ติดต่อได้ : ${patientByIDModel2.addressEmergency}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                ],
              ),
                  )),
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
      patientByIDModel2 = PatientByIDModel2.fromMap(map);
      print('pname = ${patientByIDModel2.lastName}');
      // if (productModel.pname.isEmpty) {
      // } else {}

      setState(() {
        // productModel = ProductModel.fromMap(map);
        patientByIDModels2.add(patientByIDModel2);
        // reccount = patientModels.length.toString();
      });
      // print("data");
    }

    //print('http://restaurant2019.com/htdocs/photo/${patientModels[index].patientId}.jpg');
  }
}
