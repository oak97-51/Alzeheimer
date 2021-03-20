import 'dart:convert';

import 'package:Alzeheimer/data/model_activitybyid.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../utility/my_style.dart';

class AddDetail extends StatefulWidget {
  final ActivityByIDModel activityByIDModel;
  final String paramId;
  @override
  _AddDetailState createState() => _AddDetailState();

  AddDetail({
    Key key,
    this.activityByIDModel,
    this.paramId,
  }) : super(key: key);
}

class _AddDetailState extends State<AddDetail> {
  ActivityByIDModel activityByIDModel;
  List<ActivityByIDModel> activityByIDModels = List();

  @override
  void initState() {
    super.initState();
    activityByIDModel = widget.activityByIDModel;
    // readActivity();
  }

  String time_Hour, time_Min,t_H,t_M,timeHM;
  String dropdownValue = '00';
  String dropdownValue2 = '00';
  String dropdownSize = 'g';
  String dropdownTotal = '1';
  String paramId;


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
        title: MyStyle().txt16Bold('เพิ่มรายละเอียดยาและกิจกรรม'),
        backgroundColor: MyStyle().mainColor,
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyStyle().mySizebox(),
              MyStyle().txt16BoldB('เพิ่มเวลา'),
              MyStyle().mySizebox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyStyle().txt16BoldB('เวลา'),
                  // addTime_h(context),
                  dropHour(context),
                  dropMin(context),
                ],
              ),
              MyStyle().mySizebox(),
              MyStyle().txt16BoldB('เพิ่มยารักษาโรค'),
              nameMedical(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  
                  // MyStyle().txt16BoldB('เม็ด'),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // totalMedical(context),
                  MyStyle().txt16BoldB('จำนวน'),
                  MyStyle().mySizebox(),
                  dropTotal(context),
                  MyStyle().mySizebox(),
                  MyStyle().txt16BoldB('ขนาด'),
                  MyStyle().mySizebox(),
                  dropSizeMedical(context),
                ],
              ),
              MyStyle().txt16BoldB('เพิ่มกิจกรรม'),
              addActivityDetail(context),
              MyStyle().mySizebox(),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  saveButton(),
                  MyStyle().mySizebox(),
                  backButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<Null> activityThread() async {
    //String url = 'http://127.0.0.1:8080/DeliveryFood/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&ChooseType=$chooseType';

    String urlServer =
        'http://restaurant2019.com/htdocs/addActivity.php?isAdd=true&patient_id=$paramId&at_time=$timeHM';

    try {
      // await ต้องอยู่ใน async เท่านั้นถึงจะทำงานได้
      Response response = await Dio().get(urlServer);
      print('res =$response');
      print('url : $urlServer');
    } catch (e) {
      print('Error');
    }
  }

  Future<Null> readActivity() async {
    if (activityByIDModels.length != 0) {
      activityByIDModels.clear();
    }
    String url =
        'http://restaurant2019.com/htdocs/addActivity.php?isAdd=true';
    //  print(url);
    Response response = await Dio().get(url); // read data from api
    // print('res ==> $response');
    var result = json.decode(response.data); // ถอดรหัสให้เป็น ภาษาไทย
    print('result = $result');

    for (var map in result) {
      activityByIDModel = ActivityByIDModel.fromMap(map);
      // print('pname = ${productModel.pname}');
      // if (productModel.pname.isEmpty) {
      // } else {}

      setState(() {
        // productModel = ProductModel.fromMap(map);
        activityByIDModels.add(activityByIDModel);
        // reccount = patientModels.length.toString();
      });
      // print("data");
    }
  }


  Widget dropTotal(BuildContext context) {
    return DropdownButton<String>(
      
      value: dropdownTotal,
      // icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      // underline: Container(
      //   height: 2,
      //   color: Colors.deepPurpleAccent,
      // ),
      onChanged: (String newValue) {
        setState(() {
          dropdownTotal = newValue;
        });
      },
      items: <String>[
        '1','2','3','4','5','6','7','8','9','10'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  Widget dropSizeMedical(BuildContext context) {
    return DropdownButton<String>(
      
      value: dropdownSize,
      // icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      // underline: Container(
      //   height: 2,
      //   color: Colors.deepPurpleAccent,
      // ),
      onChanged: (String newValue) {
        setState(() {
          dropdownSize = newValue;
        });
      },
      items: <String>[
        'g',
        'IU',
        'meg',
        'mcg/hr',
        'mcg/ml',
        'mEq',
        'mg',
        'mg/cm2',
        'mg/g',
        'mg/ml',
        'mL',
        '%',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget dropHour(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      // icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      // underline: Container(
      //   height: 2,
      //   color: Colors.deepPurpleAccent,
      // ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          t_H = dropdownValue;
          print('t_H = $t_H');
        });
      },
      items: <String>[
        '00',
        '01',
        '02',
        '03',
        '04',
        '05',
        '06',
        '07',
        '08',
        '09',
        '10',
        '11',
        '12',
        '13',
        '14',
        '15',
        '16',
        '17',
        '18',
        '19',
        '20',
        '21',
        '22',
        '23',
        '24',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget dropMin(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue2,
      // icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      // underline: Container(
      //   height: 2,
      //   color: Colors.deepPurpleAccent,
      // ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue2 ='00';
          dropdownValue2 = newValue;
          t_M = dropdownValue2;
          print('t_M = $t_M');
        });
      },
      items: <String>[
        '00',
        '01',
        '02',
        '03',
        '04',
        '05',
        '06',
        '07',
        '08',
        '09',
        '10',
        '11',
        '12',
        '13',
        '14',
        '15',
        '16',
        '17',
        '18',
        '19',
        '20',
        '21',
        '22',
        '23',
        '24',
        '25',
        '26',
        '27',
        '28',
        '29',
        '30',
        '31',
        '32',
        '33',
        '34',
        '35',
        '36',
        '37',
        '38',
        '39',
        '40',
        '41',
        '42',
        '43',
        '44',
        '45',
        '46',
        '47',
        '48',
        '49',
        '50',
        '51',
        '52',
        '53',
        '54',
        '55',
        '56',
        '57',
        '58',
        '59',
        '60',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Container sizeMedical(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 48,
      child: TextField(
        onChanged: (value) => time_Hour = value.trim(),
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: MyStyle().darkColor,
              fontFamily: 'BaiJamjuree',
              fontSize: 16),
          labelText: 'ขนาด (g,mg)',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor)),
          fillColor: Color(0xFFF3F5F8),
          filled: true,
        ),
      ),
    );
  }

  Container nameMedical(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 48,
      child: TextField(
        onChanged: (value) => time_Hour = value.trim(),
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: MyStyle().darkColor,
              fontFamily: 'BaiJamjuree',
              fontSize: 16),
          labelText: 'ชื่อยารักษาโรค',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor)),
          fillColor: Color(0xFFF3F5F8),
          filled: true,
        ),
      ),
    );
  }

  Container addActivityDetail(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 48,
      child: TextField(
        onChanged: (value) => time_Hour = value.trim(),
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: MyStyle().darkColor,
              fontFamily: 'BaiJamjuree',
              fontSize: 16),
          labelText: 'รายละเอียดกิจกรรม',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor)),
          fillColor: Color(0xFFF3F5F8),
          filled: true,
        ),
      ),
    );
  }

  Widget saveButton() => Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 48.0,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: MyStyle().mainColor,
            onPressed: () {
              timeHM = '$t_H:$t_M';
              print('timeHM = $timeHM');
              activityThread();
              // readActivity();
            },
            child: Text(
              'ยืนยัน',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'BaiJamjuree',
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            )),
      );

  Widget backButton() => Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 48.0,
        child: RaisedButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'ย้อนกลับ',
            style: TextStyle(
                color: MyStyle().mainColor,
                fontFamily: 'BaiJamjuree',
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: MyStyle().mainColor)),
        ),
      );

  Container totalMedical(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 48,
      child: TextField(
        onChanged: (value) => time_Hour = value.trim(),
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: MyStyle().darkColor,
              fontFamily: 'BaiJamjuree',
              fontSize: 16),
          labelText: 'จำนวน',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().primaryColor)),
          fillColor: Color(0xFFF3F5F8),
          filled: true,
        ),
      ),
    );
  }

  Container addTime_m(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 48,
      child: TextField(
          onChanged: (value) => time_Hour = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: MyStyle().darkColor,
                fontFamily: 'BaiJamjuree',
                fontSize: 16),
            labelText: 'นาที.',
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
            fillColor: Color(0xFFF3F5F8),
            filled: true,
          )),
    );
  }

  Container addTime_h(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: 48,
      child: TextField(
          onChanged: (value) => time_Hour = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: MyStyle().darkColor,
                fontFamily: 'BaiJamjuree',
                fontSize: 16),
            labelText: 'ชม.',
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
            fillColor: Color(0xFFF3F5F8),
            filled: true,
          )),
    );
  }
}
