import 'dart:convert';

import 'package:Alzeheimer/data/model_patientbyid.dart';
import 'package:Alzeheimer/screens/assignActivity/patientList.dart';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  final PatientByIDModel patientByIDModel;
  final String paramId;
  final String paramName;
  @override
  _ScheduleState createState() => _ScheduleState();
  Schedule({
    Key key,
    this.paramId,
    this.paramName,
    this.patientByIDModel,
    // this.patientModel,
  }) : super(key: key);
}

class _ScheduleState extends State<Schedule> {
  PatientByIDModel patientByIDModel;
  String paramId, paramName;

  List<PatientByIDModel> patientByIDModels = List();
  @override
  void initState() {
    super.initState();
    // user = fetchUser();
    paramId = widget.paramId;
    paramName = widget.paramName;
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
          onPressed: () {
            MaterialPageRoute route = MaterialPageRoute(
                builder: (value) => PatientList()); //วิธีเชื่อมหน้า
            Navigator.pop(context, route);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipOval(
              child: Image.asset(
                'images/middle_age_man.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 40),
              child: MyStyle().txt16Bold('${paramName} id: ${paramId}'),
            )
          ],
        ),
        backgroundColor: MyStyle().mainColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            MyStyle().mySizebox(),
            Container(
              decoration: new BoxDecoration(
                color: Colors.grey,
                borderRadius: new BorderRadius.circular(10.0),
              ),
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            MyStyle().mySizebox(),
            MyStyle().txt16BoldB('วันนี้, 8 มีนาคม 2564'),
            Expanded(
              child: ListView.builder(
                // itemCount: patientModels.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(8.0),
                  // height: MediaQuery.of(context).size.height / 1.50,
                  // width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.lightBlueAccent[50],
                    elevation: 8,
                    child: ListTile(
                      title: Row(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[],
                      ),
                      onTap: () {
                        // Toast.show("บันทึกข้อมูลเรียบร้อย", context,
                        //     duration: Toast.LENGTH_SHORT,
                        //     gravity: Toast.BOTTOM);

                        // MaterialPageRoute materialPageRoute = MaterialPageRoute(
                        //     builder: (BuildContext context) =>
                        //     Detail(paramId: patientModels[index].patientId,
                        //      ));
                        // Navigator.of(context).push(materialPageRoute);

                        //print('param : ${carModels[index].carplate}');
                      },
                    ),
                  ),
                ),
              ),
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
