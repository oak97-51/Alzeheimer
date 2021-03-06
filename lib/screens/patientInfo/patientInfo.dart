import 'dart:convert';
import 'package:Alzeheimer/data/model_patient.dart';
import 'package:Alzeheimer/data/user.dart';
import 'package:Alzeheimer/screens/home.dart';
import 'package:Alzeheimer/screens/patientInfo/detail.dart';
import 'package:Alzeheimer/screens/patientInfo/newpatient.dart';
import 'package:Alzeheimer/utility/back_dialog.dart';
import 'package:flutter/material.dart';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class PatientInfo extends StatefulWidget {
  final PatientModel patientModel;
  @override
  _PatientInfoState createState() => _PatientInfoState();

  PatientInfo({
    Key key,
    this.patientModel,
  }) : super(key: key);
}

class _PatientInfoState extends State<PatientInfo> {
  Future<List<User>> user;
  Future<List<User>> patient;
  PatientModel patientModel;
  int i;

  List<PatientModel> patientModels = List();

  String reccount = "0";

  @override
  void initState() {
    super.initState();
    // user = fetchUser();

    patientModel = widget.patientModel;
    print("pageload");
    readPatient();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                  Icons.control_point_outlined,
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
                                  deleteIcon(),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  editIcon(),
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
                            builder: (BuildContext context) => 
                            Detail(paramId: patientModels[index].patientId,
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
      // body: SingleChildScrollView(
      //   child: Container(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Container(
      //           child:Text("test")
      //         ),
      //         Expanded(
      //           child: ListView.builder(
      //             // child: Text('${patientModels[0].patientId}'),
      //             itemCount: patientModels.length,
      //             itemBuilder: (context, index) => Container(
      //               margin: EdgeInsets.all(8.0),
      //               height: MediaQuery.of(context).size.height / 1.50,
      //               width: MediaQuery.of(context).size.width,
      //               child: Card(
      //                 color: Colors.lightBlueAccent[50],
      //                 elevation: 8,
      //                 child: ListTile(
      //                   title: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.stretch,
      //                     children: <Widget>[
      //                       Row(
      //                         mainAxisSize: MainAxisSize.max,
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: <Widget>[
      //                           Container(
      //                             width:
      //                                 MediaQuery.of(context).size.width / 1.3,
      //                             margin: EdgeInsets.all(10),
      //                             child: ClipRRect(
      //                               borderRadius: BorderRadius.circular(20),
      //                               child: Text("${patientModels[index].patientId}"),
      //                               // child: Image(
      //                               //   image: NetworkImage(
      //                               //       'http://restaurant2019.com/htdocs/photo/${patientModels[index].patientId}.jpg'),
      //                               // ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       Row(
      //                         children: <Widget>[
      //                           Text(
      //                             '${patientModels[index].name}',
      //                             style: TextStyle(
      //                                 fontSize: 20,
      //                                 color: Colors.lightBlueAccent),
      //                           ),
      //                         ],
      //                       ),
      //                       Row(
      //                         children: <Widget>[
      //                           Text(
      //                             '${patientModels[index].age}',
      //                             style: TextStyle(
      //                                 fontSize: 16,
      //                                 color: Colors.blueGrey[300]),
      //                           ),
      //                         ],
      //                       ),
      //                       Row(
      //                         children: <Widget>[
      //                           Text(
      //                             'โรคประจำตัว : ${patientModels[index].disease}',
      //                             style: TextStyle(
      //                                 fontSize: 16,
      //                                 color: Colors.blueGrey[300]),
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                   // subtitle: Text(productModels[index].price_1),
      //                   // http://restaurant2018.com/api/carservice/photo/รยล9200.jpg
      //                   // trailing: Column(
      //                   //   crossAxisAlignment: CrossAxisAlignment.center,
      //                   //   children: <Widget>[
      //                   //     Image.network(
      //                   //       'http://restaurant2018.com/api/carservice/photo/${carModels[index].carplate}.jpg',
      //                   //       fit: BoxFit.fitWidth,
      //                   //     ),
      //                   //     // Image.asset(
      //                   //     //   'images/menu15.png',
      //                   //     //   width: 120,
      //                   //     //   height: 150,
      //                   //     //   fit: BoxFit.fitWidth,
      //                   //     // ),
      //                   //   ],
      //                   // ),
      //                   //   onTap: () {
      //                   //     // Toast.show("บันทึกข้อมูลเรียบร้อย", context,
      //                   //     //     duration: Toast.LENGTH_SHORT,
      //                   //     //     gravity: Toast.BOTTOM);
      //                   //     MaterialPageRoute materialPageRoute =
      //                   //         MaterialPageRoute(
      //                   //             builder: (BuildContext context) =>
      //                   //                 LoadCarDetailM1(
      //                   //                   paramMenuName: "ทะเบียนรถยนต์",
      //                   //                   paramUser: paramUser,
      //                   //                   paramCarplate:
      //                   //                       '${carModels[index].carplate}',
      //                   //                 ));
      //                   //     Navigator.of(context).push(materialPageRoute);
      //                   //     print('param : ${carModels[index].carplate}');
      //                   //   },
      //                   // )),
      //                 ),
      //               ),
      //             ),
      //             // Container(
      //             //   //width: 150,
      //             //   height: 150,
      //             //   margin:
      //             //       EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
      //             //   // height: MediaQuery.of(context).size.height / 9,
      //             //   child: getListView(),
      //             // ),
      //             // Container(
      //             //   height: screenHeight,
      //             //   child: FutureBuilder<List<User>>(
      //             //     future: fetchUser(),
      //             //     builder: (context, snapshot) {
      //             //       if (snapshot.hasData) {
      //             //         List<User> user = snapshot.data;
      //             //         return ListView.builder(
      //             //           physics:
      //             //               BouncingScrollPhysics(), // คือ เมื่อ scroll จนสุดขอบมันจะเด้ง ๆ
      //             //           scrollDirection: Axis.vertical,
      //             //           itemCount: user
      //             //               .length, //คือ ระบุว่าจะให้ list มีกี่ item หรือ จำนวน list
      //             //           itemBuilder: (BuildContext context, int index) {
      //             //             //จะทำงานตาม itemCount ที่ใช้ในการสร้าง list แต่ละตัวขึ้นมา
      //             //             return Container(
      //             //               alignment: Alignment.topCenter,
      //             //               width: screenWidth * 0.5,
      //             //               child: Card(
      //             //                 clipBehavior: Clip
      //             //                     .antiAlias, //เท่าที่เข้าใจ คือ มันช่วยลดรอยหยักของขอบภาพที่แตกใน card โดยใส่เทคนิคการเบลอเข้าไป
      //             //                 color: Colors.grey[100],
      //             //                 shape: RoundedRectangleBorder(
      //             //                   borderRadius: BorderRadius.circular(12.0),
      //             //                 ),
      //             //                 elevation:
      //             //                     1, //คือ การยกระดับของ card ขึ้นมาโดยการใส่เงาลงไป
      //             //                 child: Column(
      //             //                   crossAxisAlignment: CrossAxisAlignment.start,
      //             //                   children: <Widget>[
      //             //                     // AspectRatio(
      //             //                     //   aspectRatio: 15.0 / 11.0,
      //             //                     //   child: Image.network(
      //             //                     //     user[index].image,
      //             //                     //     fit: BoxFit.cover,
      //             //                     //   ),
      //             //                     // ),
      //             //                     Padding(
      //             //                       padding: EdgeInsets.only(
      //             //                         left: 10.0,
      //             //                         right: 16.0,
      //             //                         top: 12.0,
      //             //                         bottom: 8.0,
      //             //                       ),
      //             //                       child: Row(
      //             //                         children: <Widget>[
      //             //                           Container(
      //             //                             alignment: Alignment.center,
      //             //                             child: Image.network(
      //             //                               user[index].profile,
      //             //                               //patientModels[index].photo,
      //             //                               fit: BoxFit.cover,
      //             //                             ),
      //             //                           ),
      //             //                           Container(
      //             //                             child: Text(
      //             //                               user[index].title,
      //             //                               //patientModels[index].name,
      //             //                             ),
      //             //                           ),
      //             //                           Container(
      //             //                             child: Text('${user[index].id}'),
      //             //                           ),
      //             //                         ],
      //             //                       ),
      //             //                     ),
      //             //                   ],
      //             //                 ),
      //             //               ),
      //             //             );
      //             //           },
      //             //         );
      //             //       }
      //             //       return Center(
      //             //         child: SizedBox(
      //             //           height: 100,
      //             //           width: 100,
      //             //           child: CircularProgressIndicator(
      //             //             // strokeWidth: 10,
      //             //             //backgroundColor: Colors.cyanAccent,
      //             //             valueColor: new AlwaysStoppedAnimation<Color>(
      //             //                 MyStyle().mainColor),
      //             //           ),
      //             //         ),
      //             //       );
      //             //     },
      //             //   ),
      //             // ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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

  // Future<Null> routeToService(Widget myWidget, UserModel userModel) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('id',userModel.adminId);
  //   preferences.setString('Email',userModel.email);
  //   preferences.setString('LastName',userModel.lastName);
  //   preferences.setString('FirstName',userModel.firstName);

  //   MaterialPageRoute route = MaterialPageRoute (builder: (context) => myWidget,);
  //   Navigator.pushAndRemoveUntil(context,route,(route)=>false);
  // }

  Container editIcon() {
    return Container(
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
    );
  }

  Container deleteIcon() {
    return Container(
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
    );
  }

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
            style: TextStyle(fontSize: 20, color: Colors.lightBlueAccent),
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
              //       onPressed: () {/* ... */},
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
