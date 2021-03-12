import 'dart:convert';

import 'package:Alzeheimer/data/model_patient.dart';
import 'package:Alzeheimer/data/model_patientbyid.dart';
import 'package:Alzeheimer/screens/assignActivity/schedule.dart';
import 'package:Alzeheimer/screens/home.dart';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PatientList extends StatefulWidget {
  final PatientByIDModel patientFullModel;
  @override
  _PatientListState createState() => _PatientListState();
  PatientList({
    Key key,
    this.patientFullModel,
  }) : super(key: key);
}

class _PatientListState extends State<PatientList> {
  PatientByIDModel patientFullModel;
  List<PatientByIDModel> patientFullModels = List();
  String reccount = "0";
  @override
  void initState() {
    super.initState();
    // user = fetchUser();

    patientFullModel = widget.patientFullModel;
    print("pageload");
    readPatient();
  }

  Future<Null> readPatient() async {
    String url =
        'http://restaurant2019.com/htdocs/fetch_patient.php?isAdd=true';
    //  print(url);
    Response response = await Dio().get(url); // read data from api
    // print('res ==> $response');
    var result = json.decode(response.data); // ถอดรหัสให้เป็น ภาษาไทย
    print('result = $result');

    for (var map in result) {
      patientFullModel = PatientByIDModel.fromMap(map);
      // print('pname = ${productModel.pname}');
      // if (productModel.pname.isEmpty) {
      // } else {}

      setState(() {
        // productModel = ProductModel.fromMap(map);
        patientFullModels.add(patientFullModel);
        reccount = patientFullModels.length.toString();
      });
      // print("data");
    }
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
          onPressed: () {
               MaterialPageRoute route = MaterialPageRoute(
                    builder: (value) => Home()) ; //วิธีเชื่อมหน้า
                Navigator.pop(context, route);
              },
        ),
        title: MyStyle().txt16Bold('รายชื่อคนไข้'),
        backgroundColor: MyStyle().mainColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text("test"),
                Container(
                    color: Colors.white,
                    child: Text(
                      'จำนวนผู้ป่วย : $reccount  คน',
                      style:
                          TextStyle(fontSize: 18, color: Colors.blueGrey[300]),
                    )),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: patientFullModels.length,
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
                          MyStyle().txt16BoldB('${patientFullModels[index].patientId} . '),
                          MyStyle().txt16BoldB('${patientFullModels[index].firstName} ${patientFullModels[index].lastName} อายุ ${patientFullModels[index].age}'),
                        ],
                      ),
                      onTap: () {
                        // Toast.show("บันทึกข้อมูลเรียบร้อย", context,
                        //     duration: Toast.LENGTH_SHORT,
                        //     gravity: Toast.BOTTOM);


                        MaterialPageRoute materialPageRoute = MaterialPageRoute(
                            builder: (BuildContext context) => 
                            Schedule(paramId: patientFullModels[index].patientId,paramName: patientFullModels[index].firstName,
                             ));
                        Navigator.of(context).push(materialPageRoute);


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
}
