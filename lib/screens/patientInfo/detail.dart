import 'dart:convert';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Alzeheimer/data/model_patientbyid.dart';
// import 'package:http/http.dart' as http;

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
                                child: Image.network('${patientByIDModel.img}')),
                          )
                          // Text('เลขที่บัตรประชาชน : ${patientByIDModel.identity}'),
                        ]),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ชื่อ-นามสกุล : ${patientByIDModel.firstName}  ${patientByIDModel.lastName}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     เลขที่บัตรประชาชน : ${patientByIDModel.identity}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     วันเดือนปีเกิด : ${patientByIDModel.dateOfBirth}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     เพศ : ${patientByIDModel.gender}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     อายุ : ${patientByIDModel.age}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     อาชีพ : ${patientByIDModel.career}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     สัญชาติ : ${patientByIDModel.nationality}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ศาสนา : ${patientByIDModel.religion}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     หมู่เลือด : ${patientByIDModel.bloodGroup}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ที่อยู่ : ${patientByIDModel.address}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     เบอร์โทรศัพท์ : ${patientByIDModel.tel}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ชื่อ-นามสกุล บิดา : ${patientByIDModel.nameOfDad}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ชื่อ-นามสกุล มารดา : ${patientByIDModel.nameOfMom}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ชื่อผู้ติดต่อได้กรณีฉุกเฉิน : ${patientByIDModel.nameEmergency}',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '     ที่อยู่ผู้ติดต่อได้ : ${patientByIDModel.addressEmergency}',
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
