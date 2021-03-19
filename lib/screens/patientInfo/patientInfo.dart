import 'dart:convert';
import 'package:Alzeheimer/data/model_patient.dart';
import 'package:Alzeheimer/data/model_patientFull.dart';
import 'package:Alzeheimer/data/model_patientbyid.dart';
import 'package:Alzeheimer/data/model_patientbyid2.dart';
import 'package:Alzeheimer/data/user.dart';
import 'package:Alzeheimer/screens/home.dart';
import 'package:Alzeheimer/screens/patientInfo/detail.dart';
import 'package:Alzeheimer/screens/patientInfo/newpatient.dart';
import 'package:Alzeheimer/screens/patientInfo/editPatientInfo.dart';
import 'package:Alzeheimer/utility/normal_dialog.dart';
// import 'package:Alzeheimer/utility/back_dialog.dart';
import 'package:flutter/material.dart';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientInfo extends StatefulWidget {
  final PatientModel patientModel;
  final PatientByIDModel2 patientByIDModel2;
  @override
  _PatientInfoState createState() => _PatientInfoState();

  PatientInfo({
    Key key,
    this.patientModel,
    this.patientByIDModel2,
  }) : super(key: key);
}

class _PatientInfoState extends State<PatientInfo> {
  Future<List<User>> user;
  Future<List<User>> patient;
  PatientModel patientModel;
  PatientByIDModel2 patientByIDModel2;
  int i;

  List<PatientModel> patientModels = List();
  List<PatientByIDModel2> patientByIDModels2 = List();

  String reccount = "0";

  @override
  void initState() {
    super.initState();
    // user = fetchUser();

    patientModel = widget.patientModel;
    patientByIDModel2 = widget.patientByIDModel2;
    print("pageload");
    
    //readPatient1 กับ 2 โมเดลคนละตัว 1 ใช้ delete 2 ใช้ edit อนาคตต้องแก้
    readPatient();
    readPatient2();
    
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => Home()); //วิธีเชื่อมหน้า
            Navigator.of(context).pop();
          },
        ),
        title: MyStyle().txt16Bold('ประวัติผู้ป่วย'),
        backgroundColor: MyStyle().mainColor,
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (value) => NewPatient()); //วิธีเชื่อมหน้า
                  Navigator.push(context, route);
                },
                child: Icon(
                  Icons.control_point,
                  size: 28,
                ),
              )),
        ],
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
                itemCount: patientModels.length,
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
                        children: <Widget>[
                          patientAvatar(context, index),
                          Column(
                            children: <Widget>[
                              formDetail(index),
                              Row(
                                children: [
                                  InkWell(
                                    child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: Colors.black,
                                      onPressed: () {
                                        confirmDialog(index);

                                        // deletePatient(patientModels[index]);
                                      },
                                    ),
                                  ),
                                  // deleteIcon(index),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  // editIcon(),
                                  InkWell(
                                    child: IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Colors.black,
                                      onPressed: () {
                                        print('Hello');
                                        deletePatient(patientModels[index]);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        // Toast.show("บันทึกข้อมูลเรียบร้อย", context,
                        //     duration: Toast.LENGTH_SHORT,
                        //     gravity: Toast.BOTTOM);
                        MaterialPageRoute materialPageRoute = MaterialPageRoute(
                            builder: (BuildContext context) => Detail(
                                  paramId: patientModels[index].patientId,
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

    // Column(
    //   children: <Widget>[
    //     testBox(),
    //     //testBox2(),
    //     Center(
    //       child: Card(
    //         child: InkWell(
    //           splashColor: Colors.blue.withAlpha(30),
    //           onTap: () {
    //             print('Card tapped.');
    //           },
    //           child: Row(
    //             children: <Widget>[
    //               //imageBox(context),
    //               ListTile(
    //                 leading: ConstrainedBox(
    //                   constraints: BoxConstraints(
    //                     minWidth: 172,
    //                     minHeight: 164,
    //                     maxWidth: 172,
    //                     maxHeight: 164,
    //                   ),
    //                   child: Image.asset(
    //                     'images/middle_age_man.png',
    //                     fit: BoxFit.cover,
    //                     // height: 164,
    //                     // width: 172,
    //                   ),
    //                 ),
    //                 title: Text('The Enchanted Nightingale'),
    //                 subtitle:
    //                     Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
    //               )
    //               // Container(
    //               //   margin: const EdgeInsets.only(left: 1, top: 2),
    //               //   child: MyStyle().txt16BoldMain("ชื่อ: นาย ยินดี ไม่มีปัญหา")
    //               // ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // ),
  }

  Future<Null> editThread() async {
    String patientId = patientByIDModel2.patientId;
    String id = patientModel.patientId;
    print('id = ${patientModel.patientId}');
    print('test_id');
  }
  

  Future<Null> routeToService(Widget myWidget, PatientByIDModel patientByIDModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('PatientId', patientByIDModel.patientId);
    preferences.setString('FirstName', patientByIDModel.firstName);
    preferences.setString('LastName', patientByIDModel.lastName);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget, 
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }


  Future<Null> confirmDialog(int index) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการแก้ไข้ข้อมูล ?'),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  Navigator.pop(context);
                  // editThread();


                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (value) => EditPatientInfo(paramId: patientByIDModels2[index].patientId,paramFirstName: patientByIDModels2[index].firstName,paramLastName: patientByIDModels2[index].lastName,
                      paramImg:patientByIDModels2[index].img,paramAge: patientByIDModels2[index].age,paramDisease: patientByIDModels2[index].disease,paramGender: patientByIDModels2[index].gender,
                      paramIdentity: patientByIDModels2[index].identity,paramDateOfBirth: patientByIDModels2[index].dateOfBirth,paramCareer: patientByIDModels2[index].career,
                      paramNationality: patientByIDModels2[index].nationality,paramReligion: patientByIDModels2[index].religion,paramBloodGroup: patientByIDModels2[index].bloodGroup,
                      paramAddress: patientByIDModels2[index].address,paramTel: patientByIDModels2[index].tel,paramNameOfMom:patientByIDModels2[index].nameOfMom,paramNameOfDad: patientByIDModels2[index].nameOfDad,
                      paramNameEmergency: patientByIDModels2[index].nameEmergency,paramAddressEmergency: patientByIDModels2[index].addressEmergency,paramTelEmergency: patientByIDModels2[index].telEmergency,
                      paramEtc: patientByIDModels2[index].etc,paramHistoryAllergy: patientByIDModels2[index].historyAllergy,)); //วิธีเชื่อมหน้า
                  Navigator.push(context, route).then((value) => readPatient2());
                  //.then((value) => readPatient());


                  // routeToService(EditPatientInfo(),patientByIDModel);

                  // print('Name Patient : ${patientByIDModel.firstName}');
                },
                child: Text('ยืนยัน'),
              ),
              OutlineButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ยกเลิก'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector deleteIcon(int index) {
    return GestureDetector(
      onTap: () {
        normalDialog(context, 'Hello');
        // deletePatient(patientModels[index]);
        print('In');
      },
      child: Container(
        height: 30,
        width: 30,
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: MyStyle().mainColor,
          child: Image.asset(
            'images/delete_icon.png',
            height: 16,
            width: 16,
          ),
          shape: CircleBorder(),
        ),
      ),
    );
  }

  // Future<Null> routeToService(Widget myWidget, UserModel userModel) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('id',userModel.adminId);
  //   preferences.setString('Email',userModel.email);
  //   preferences.setString('LastName',userModel.lastName);
  //   preferences.setString('FirstName',userModel.firstName);

  //   MaterialPageRoute route = MaterialPageRoute (builder: (context) => myWidget,);
  //   Navigator.pushAndRemoveUntil(context,route,(route)=>false);
  // }

  InkWell editIcon() {
    return InkWell(
      onTap: () {
        print('Hello');
      },
      child: Container(
        height: 30,
        width: 30,
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: MyStyle().mainColor,
          child: Image.asset(
            'images/edit_icon.png',
            height: 16,
            width: 16,
          ),
          //padding: EdgeInsets.all(10.0),
          shape: CircleBorder(),
        ),
      ),
    );
  }

  Future<Null> deletePatient(PatientModel patientModel2) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title:
            MyStyle().txt16BoldB('ต้องการลบผู้ป่วย ชื่อ ${patientModel2.name}'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String url =
                      'http://restaurant2019.com/htdocs/deletePatient.php?isAdd=true&PatientId=${patientModel2.patientId}';
                  await Dio().get(url).then((value) => readPatient());
                },
                child: Text('ยืนยัน'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ยกเลิก'),
              )
            ],
          )
        ],
      ),
    );
  }

  //print('http://restaurant2019.com/htdocs/photo/${patientModels[index].patientId}.jpg');

  Row patientAvatar(BuildContext context, int index) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 3.5,
          //height: MediaQuery.of(context).size.height /4,
          margin: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: NetworkImage('${patientModels[index].img}'),
            ),
          ),
        ),
      ],
    );
  }

  Container formDetail(int index) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(),
          Text(
            'ชื่อ : ${patientModels[index].name}',
            style: TextStyle(fontSize: 16, color: Colors.lightBlueAccent),
            //textAlign: TextAlign.left,
          ),
          Text(
            'อายุ : ${patientModels[index].age}',
            style: TextStyle(fontSize: 16, color: Colors.blueGrey[300]),
            textAlign: TextAlign.left,
          ),
          Text(
            'โรค : ${patientModels[index].disease}',
            style: TextStyle(fontSize: 16, color: Colors.blueGrey[300]),
            //textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  SingleChildScrollView test1() {
    SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      child: Card(
                        color: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 8,
                        child: Container(
                          child: Center(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return null;
  }

  Future<List<User>> fetchUser() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/photos');
    String logResponse = response.statusCode.toString();
    if (response.statusCode == 200) {
      print('ResponseStatusCode: $logResponse'); // Check Status Code = 200
      print('ResponseBody: ' + response.body); // Read Data in Array
      List<dynamic> responseJson = json.decode(response.body);
      return responseJson.map((m) => new User.fromJson(m)).toList();
    }
  }

  Future<List<User>> testFetch() async {
    final response =
        await http.get('http://restaurant2019.com/htdocs/fetch_patient.php');
    String logResponse = response.statusCode.toString();
    if (response.statusCode == 200) {
      print('ResponseStatusCode: $logResponse'); // Check Status Code = 200
      print('ResponseBody: ' + response.body); // Read Data in Array
      List<dynamic> responseJson = json.decode(response.body);
      return responseJson.map((m) => new User.fromJson(m)).toList();
    }
  }

  Container imageBox(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            'images/middle_age_man.png',
            fit: BoxFit.cover,
            width: 164,
            height: 172,
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.5,
      // height: 220,
      // width: 350,
      //child: Text('A card that can be tapped'),
    );
  }

  Widget testBox2() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            width: 100,
            height: 100,
          ),
          Expanded(
              child: Container(
            color: Colors.amber,
            width: 100,
          )),
        ],
      ),
    );
  }

  Widget testBox() {
    {
      return Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 172,
                    minHeight: 164,
                    maxWidth: 172,
                    maxHeight: 164,
                  ),
                  child: Image.asset(
                    'images/middle_age_man.png',
                    fit: BoxFit.cover,
                    // height: 164,
                    // width: 172,
                  ),
                ),
                title: Text('The Enchanted Nightingale'),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     TextButton(
              //       child: const Text('BUY TICKETS'),
              //       onPressed : () {/* ... */},
              //     ),
              //     const SizedBox(width: 8),
              //     TextButton(
              //       child: const Text('LISTEN'),
              //       onPressed: () {/* ... */},
              //     ),
              //     const SizedBox(width: 8),
              //   ],
              // ),
            ],
          ),
        ),
      );
    }
  }

  Future<Null> readPatient() async {
    if (patientModels.length != 0) {
      patientModels.clear();
    }
    String url =
        'http://restaurant2019.com/htdocs/fetch_patient.php?isAdd=true';
    //  print(url);
    Response response = await Dio().get(url); // read data from api
    // print('res ==> $response');
    var result = json.decode(response.data); // ถอดรหัสให้เป็น ภาษาไทย
    print('result = $result');

    for (var map in result) {
      patientModel = PatientModel.fromMap(map);
      // print('pname = ${productModel.pname}');
      // if (productModel.pname.isEmpty) {
      // } else {}

      setState(() {
        // productModel = ProductModel.fromMap(map);
        patientModels.add(patientModel);
        reccount = patientModels.length.toString();
      });
      // print("data");
    }

    //print('http://restaurant2019.com/htdocs/photo/${patientModels[index].patientId}.jpg');
  }

  Future<Null> readPatient2() async {
    if (patientByIDModels2.length != 0) {
      patientByIDModels2.clear();
    }
    String url =
        'http://restaurant2019.com/htdocs/fetch_patient.php?isAdd=true';
    //  print(url);
    Response response = await Dio().get(url); // read data from api
    // print('res ==> $response');
    var result = json.decode(response.data); // ถอดรหัสให้เป็น ภาษาไทย
    print('result = $result');

    for (var map in result) {
      patientByIDModel2 = PatientByIDModel2.fromMap(map);
      // print('pname = ${productModel.pname}');
      // if (productModel.pname.isEmpty) {
      // } else {}

      setState(() {
        // productModel = ProductModel.fromMap(map);
        patientByIDModels2.add(patientByIDModel2);
        reccount = patientByIDModels2.length.toString();
      });
      // print("data");
    }

    //print('http://restaurant2019.com/htdocs/photo/${patientModels[index].patientId}.jpg');
  }

// Container test(){
//   return Container(
//     height: MediaQuery.of(context).size.height * 0.3,
//     width: MediaQuery.of(context).size.width * 0.9,
//     color: Colors.red,
//   );
// }

  getItem() {
    var row = Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.redAccent,
            ),
            child: Image.asset('images/middle_age_man.png'),
          ),
        ],
      ),
    );
    return Card(
      color: Colors.blueGrey,
      child: row,
    );
  }
}
