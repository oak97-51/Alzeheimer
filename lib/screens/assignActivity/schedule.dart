import 'dart:convert';
import 'dart:async';
import 'package:Alzeheimer/data/model_patientbyid.dart';
import 'package:Alzeheimer/data/model_activitybyid.dart';
import 'package:Alzeheimer/screens/assignActivity/patientList.dart';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:Alzeheimer/screens/assignActivity/addDetail.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:intl/date_symbol_data_local.dart';

class Schedule extends StatefulWidget {
  final PatientByIDModel patientByIDModel;
  final ActivityByIDModel activityByIDModel;
  final String paramId;
  final String paramName;
  final String paramLName;
  @override
  _ScheduleState createState() => _ScheduleState();
  Schedule({
    Key key,
    this.paramId,
    this.paramName,
    this.paramLName,
    this.patientByIDModel,
    this.activityByIDModel,
    // this.patientModel,
  }) : super(key: key);
}

class _ScheduleState extends State<Schedule> {
  PatientByIDModel patientByIDModel;
  ActivityByIDModel activityByIDModel;
  String paramId, paramName, paramLName;

  // FlutterTts flutterTts;
  // dynamic languages;
  // String language;
  // double volume = 0.5;
  // double pitch = 1.0;
  // double rate = 0.5;

  // String newVoiceText;

  // TtsState ttsState = TtsState.stopped;

  // get isPlaying => ttsState == TtsState.playing;

  // get isStopped => ttsState == TtsState.stopped;

  CalendarController calendarControllerX;
  Map<DateTime, List> xevents;
  List xselectedEvents;
  AnimationController animationControllerx;

  List<PatientByIDModel> patientByIDModels = List();
  List<ActivityByIDModel> activityByIDModels = List();
  @override
  void initState() {
    super.initState();
    calendarControllerX = CalendarController();
    xevents = {};
    xselectedEvents = [];
    // user = fetchUser();
    paramId = widget.paramId;
    paramName = widget.paramName;
    paramLName = widget.paramLName;
    patientByIDModel = widget.patientByIDModel;
    activityByIDModel = widget.activityByIDModel;

    readPatient();
    //  readActivity(date.toUtc());
  }

  @override
  void dispose() {
    calendarControllerX.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tableCalendar = TableCalendar(
      calendarStyle: CalendarStyle(
      
          todayColor: Colors.blue,
          // selectedColor: Theme.of(context).primaryColor,
          selectedColor: Theme.of(context).backgroundColor,
          todayStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: Colors.white)),
      events: xevents,
      initialCalendarFormat: CalendarFormat.week,
      calendarController: calendarControllerX,
      onDaySelected: (date, events, e) {
        // print('วันที่เลือก : ${date.toUtc().toString()}');
        setState(() {
          readActivity(date.toUtc());
        });
      },
    );
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
              child:
                  MyStyle().txt16Bold('$paramName  $paramLName id: $paramId'),
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
                color: Colors.white,
                borderRadius: new BorderRadius.circular(10.0),
              ),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              child: tableCalendar,
            ),
            MyStyle().mySizebox(),
            // MyStyle().txt16BoldB('วันนี้, 11 มีนาคม 2564'),
            Expanded(
              child: ListView.builder(
                itemCount: activityByIDModels.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(8.0),
                  // height: MediaQuery.of(context).size.height / 1.50,
                  // width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.lightBlueAccent[50],
                    elevation: 8,
                    child: ListTile(
                      // leading: Icon(Icons.arrow_drop_down_circle),
                      // leading: Container(
                      //     child: Column(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Icon(Icons.arrow_drop_down_circle),
                      //         Icon(Icons.delete_forever),
                      //         Icon(Icons.edit),
                      //       ],
                      //     )
                      //   ],
                      // )),
                      title: Container(
                        decoration:
                            BoxDecoration(color: Colors.deepPurple[100]),
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.adjust,
                                      color: Colors.deepPurple[300],
                                      size: 32,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    MyStyle().txt16BoldB(
                                        '${activityByIDModels[index].attime}'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_box,
                                          color: Colors.deepPurple[300],
                                          size: 32,
                                        ),
                                        Icon(
                                          Icons.delete,
                                          color: Colors.deepPurple[300],
                                          size: 32,
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.deepPurple[300],
                                          size: 32,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      subtitle: Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                MyStyle().txt16BoldB('  '),
                              ],
                            ),
                            Row(
                              children: [
                                MyStyle().txt16BoldB(
                                    '${activityByIDModels[index].description}  '),
                              ],
                            ),
                            Row(
                              children: [
                                MyStyle().txt16BoldB(
                                    '${activityByIDModels[index].drug}  '),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // trailing: MyStyle()
                      //     .txt16BoldB('${activityByIDModels[index].drug}'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
                      builder: (value) => AddDetail()); //วิธีเชื่อมหน้า
                  Navigator.push(context, route);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<Null> readPatient() async {
    print('param ID : $paramId');
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

  Future<Null> readActivity(varDate) async {
    // print('param ID : $paramId');
    // print('param ID : $varDate');
    // print(' Date : ${varDate.toString().substring(0, 10)}');
    String paramDate;
    paramDate = varDate.toString().substring(0, 10);
    String url =
        'http://restaurant2019.com/htdocs/fetch_activity.php?isAdd=true&id=$paramId&cdate=$paramDate';

    print('url : $url');

    Response response = await Dio().get(url); // read data from api
    // print('res ==> $response');
    var result = json.decode(response.data); // ถอดรหัสให้เป็น ภาษาไทย
    // print('result = $result');

    activityByIDModels.clear();
    for (var map in result) {
      activityByIDModel = ActivityByIDModel.fromMap(map);
      print('pname = ${activityByIDModel.description}');
      // if (productModel.pname.isEmpty) {
      // } else {}

      setState(() {
        // productModel = ProductModel.fromMap(map);
        activityByIDModels.add(activityByIDModel);

        // reccount = patientModels.length.toString();
      });
    }
  }
}
