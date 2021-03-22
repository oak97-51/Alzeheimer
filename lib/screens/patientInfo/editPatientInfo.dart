import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:Alzeheimer/data/model_patientbyid.dart';
import 'package:Alzeheimer/screens/home.dart';
import 'package:Alzeheimer/screens/patientInfo/detail.dart';
import 'package:Alzeheimer/screens/patientInfo/patientInfo.dart';
import 'package:Alzeheimer/utility/back_dialog.dart';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:Alzeheimer/utility/my_constant.dart';
import 'package:Alzeheimer/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPatientInfo extends StatefulWidget {
  final PatientByIDModel patientModelIDModel;
  final String paramId,paramFirstName,paramLastName,paramImg,
  paramAge,paramDisease,paramGender,paramIdentity,paramDateOfBirth,paramCareer,paramNationality,
  paramReligion,paramBloodGroup,paramAddress,paramTel,paramNameOfMom,paramNameOfDad,paramNameEmergency,
  paramAddressEmergency,paramTelEmergency,paramEtc,paramHistoryAllergy;
  @override
  _EditPatientInfoState createState() => _EditPatientInfoState();

  EditPatientInfo({
    Key key,
    this.patientModelIDModel,
    this.paramId,
    this.paramFirstName,
    this.paramLastName,
    this.paramImg,
    this.paramAge,
    this.paramDisease,
    this.paramGender,
    this.paramIdentity,
    this.paramDateOfBirth,
    this.paramCareer,
    this.paramNationality,
    this.paramReligion,
    this.paramBloodGroup,
    this.paramAddress,
    this.paramTel,this.paramNameOfMom,this.paramNameOfDad,this.paramNameEmergency,this.paramAddressEmergency,this.paramTelEmergency,this.paramEtc,this.paramHistoryAllergy
  }) : super(key: key);
}

class _EditPatientInfoState extends State<EditPatientInfo> {
  PatientByIDModel patientModelIDModel;
  List<PatientByIDModel> patientByIDModels = List();
  String paramId,paramFirstName,paramLastName,paramImg,
  paramAge,paramDisease,paramGender,paramIdentity,paramDateOfBirth,paramCareer,paramNationality,
  paramReligion,paramBloodGroup,paramAddress,paramTel,paramNameOfMom,paramNameOfDad,paramNameEmergency,
  paramAddressEmergency,paramTelEmergency,paramEtc,paramHistoryAllergy;
  @override
  void initState() {
    super.initState();
    // user = fetchUser();
    paramId = widget.paramId;
    paramFirstName = widget.paramFirstName;
    paramLastName = widget.paramLastName;
    paramImg = widget.paramImg;
    paramAge = widget.paramAge;
    paramDisease = widget.paramDisease;
    paramGender = widget.paramGender;
    paramIdentity = widget.paramIdentity;
    paramDateOfBirth = widget.paramDateOfBirth;
    paramCareer = widget.paramCareer;
    paramNationality = widget.paramNationality;
    paramReligion = widget.paramReligion;
    paramBloodGroup = widget.paramBloodGroup;
    paramAddress = widget.paramAddress;
    paramTel = widget.paramTel; paramNameOfMom = widget.paramNameOfMom; paramNameOfDad = widget.paramNameOfDad; 
    paramNameEmergency = widget.paramNameEmergency; paramAddressEmergency = widget.paramAddressEmergency; paramTelEmergency = widget.paramTelEmergency;
    paramEtc = widget.paramEtc; paramHistoryAllergy = widget.paramHistoryAllergy;

    // patientModelIDModel = widget.patientModelIDModel;
    print("pageload");
    // readPatient();
    // userPreferences();
  }
  File file;
  //asdasdasdad
  String firstName,
      test3,
      test4,
      lastName,
      age,
      disease,
      identity,
      dateOfBirth,
      career,
      nationality,
      religion,
      bloodGroup,
      address,
      tel,
      nameOfMom,
      nameOfDad,
      nameEmergency,
      telEmergency,
      etc,
      historyAllergy,
      gender,
      addressEmergency,
      img;
  String user, password,urlImage,patientId;
  String contact;
  Future<Null> userPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      firstName = preferences.getString('FirstName');
      lastName = preferences.getString('LastName');
      patientId = preferences.getString('PatientId');
    });
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: MyStyle().txt16Bold('แบบฟอร์มแก้ไขเอกสารผู้ป่วย'),
        backgroundColor: MyStyle().mainColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                //height: screenHeight,
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),

                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      MyStyle().mySizebox(),
                      MyStyle().txt20RegularB('ข้อมูลผู้ป่วย'),
                      MyStyle().mySizebox(),
                      textSubtitle('ชื่อ'),
                      nameForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('นามสกุล'),
                      surnameForm(),
                      MyStyle().mySizebox(),
                      Row(
                        children: [
                          genderManRadio(),
                          genderWomanRadio(),
                        ],
                      ),
                      textSubtitle('เลขบัตรประชาชน'),
                      identityForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('วัน / เดือน / ปี ที่เกิด'),
                      dateOfBirthForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('อายุ'),
                      ageForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('โรคประจำตัว'),
                      diseaseForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('อาชีพ'),
                      careerForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('สัญชาติ'),
                      nationalityForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('ศาสนา'),
                      religionForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('หมุ่เลือด'),
                      bloodGroupForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('ที่อยู่'),
                      addressForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('เบอร์โทรศัพท์'),
                      telForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('ชื่อ - นามสกุล บิดา'),
                      nameDadForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('ชื่อ - นามสกุล มารดา'),
                      nameMomForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('ผู้ติดติดได้ในกรณีฉุกเฉิน'),
                      emergencyContactForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('ที่อยู่ผู้ติดต่อได้'),
                      emergencyAddressForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('เบอร์โทรศัพท์ผู้ติดต่อได้กรณีฉุกเฉิน'),
                      emergencyTelForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('ผู้ติดต่อได้เกี่ยวข้องเป็น'),
                      Column(
                        children: [
                          SingleChildScrollView(
                            child: Row(
                              children: [
                                dadRadio(),
                                momRadio(),
                                childRadio(),
                                wifeRadio(),
                              ],
                            ),
                          ),
                          Wrap(
                            spacing: 1.0, // gap between adjacent chips
                            runSpacing: 1.0, // gap between lines
                            direction: Axis.horizontal,
                            children: <Widget>[
                              Row(
                                children: [
                                  husbandRadio(),
                                  relativeRadio(),
                                  parentRadio(),
                                  bossRadio(),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              friendRadio(),
                              etcRadio(),
                            ],
                          ),
                        ],
                      ),
                      etcForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('ประวัติแพ้ยา'),
                      drugAllergyForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('รูปภาพ'),
                      groupImage(),
                      MyStyle().mySizebox(),
                      textPhoto(),
                      MyStyle().mySizebox(),
                    ],
                  ),
                ),
              ),
              MyStyle().mySizebox(),
              Row(
                children: [
                  MyStyle().mySizeboxw24(),
                  backButton(),
                  MyStyle().mySizeboxw24(),
                  editButton(),
                ],
              ),
              MyStyle().mySizebox(),
            ],
          ),
        ),
      ),
    );
  }
  Future<Null> updatePatient() async {
    print('ParamId =  $paramId');

    String url = 'http://restaurant2019.com/htdocs/updatePatient.php?isAdd=true&PatientId=$paramId&Img=$img&FirstName=$paramFirstName&Age=$paramAge&Disease=$paramDisease&LastName=$paramLastName&Gender=$paramGender&Identity=$paramIdentity&DateOfBirth=$paramDateOfBirth&Career=$paramCareer&Nationality=$paramNationality&Religion=$paramReligion&BloodGroup=$paramBloodGroup&Address=$paramAddress&Tel=$paramTel&NameOfMom=$paramNameOfMom&NameOfDad=$paramNameOfDad&NameEmergency=$paramNameEmergency&AddressEmergency=$paramAddressEmergency&TelEmergency=$paramTelEmergency&Etc=$paramEtc&HistoryAllergy=$paramHistoryAllergy';

    Response res = await Dio().get(url);
    if(res.toString() == 'true'){
      // MaterialPageRoute route =
      //         MaterialPageRoute(builder: (value) => Detail()); //วิธีเชื่อมหน้า
      //     Navigator.push(context, route);
      MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => PatientInfo()); //วิธีเชื่อมหน้า
          Navigator.push(context, route).then((value) => readPatient());
    }else{
      normalDialog(context,'ยังไม่สำเร็จ');
    }
  }
  Future<Null> readPatient() async {
    if (patientByIDModels.length != 0) {
      patientByIDModels.clear();
    }
    String url =
        'http://restaurant2019.com/htdocs/fetch_patient.php?isAdd=true';
    //  print(url);
    Response response = await Dio().get(url); // read data from api
    // print('res ==> $response');
    var result = json.decode(response.data); // ถอดรหัสให้เป็น ภาษาไทย
    print('result = $result');

    for (var map in result) {
      patientModelIDModel = PatientByIDModel.fromMap(map);
      // print('pname = ${productModel.pname}');
      // if (productModel.pname.isEmpty) {
      // } else {}

      setState(() {
        // productModel = ProductModel.fromMap(map);
        patientByIDModels.add(patientModelIDModel);
        // reccount = patientModels.length.toString();
      });
      // print("data");
    }

    //print('http://restaurant2019.com/htdocs/photo/${patientModels[index].patientId}.jpg');
  }

  Column groupImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: file == null
              ? Image.asset('images/middle_age_man.png')
              : Image.file(file),
        ),
        MyStyle().freeSizebox(20, 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            takePhotoButton(),
            MyStyle().mySizebox(),
            choosePhotoButton(),
          ],
        ),
      ],
    );
  }

  Widget takePhotoButton() => Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 36.0,
        //padding: EdgeInsets.only(left:20),
        child: RaisedButton(
          color: Colors.white,
          onPressed: () => chooseImage(ImageSource.camera),
          child: Text(
            'ถ่ายรูปภาพ',
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

  Widget choosePhotoButton() => Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 36.0,
        //padding: EdgeInsets.only(left:20),
        child: RaisedButton(
          color: Colors.white,
          onPressed: () => chooseImage(ImageSource.gallery),
          child: Text(
            'เลือกรูปภาพ',
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

  Future<Null> chooseImage(ImageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: ImageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );

      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget textPhoto() => Container(
        child: Text('''ขนาดไฟล์: สูงสุด 1 MB
ไฟล์ที่รองรับ: .JPEG , .PNG'''),
      );

  Widget genderManRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            //width: 100,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: '$paramGender',
                  groupValue: gender,
                  focusColor: Colors.black,
                  onChanged: (value) {
                    print('$value');
                      setState(() {
                      
                      gender = value;
                      print('$value');
                    });
                  },
                ),
                Text(
                  'ชาย',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Future<Null> changeGender(value) async{
        if(value == paramGender){
          setState(() {
            value = null;
                      // gender = value;
            print('$value');
          });
        }else{
          setState(() {
          value = true;                  
          });
        }

  }

  Widget genderWomanRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            // width: 250.0,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: 'woman',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
                Text(
                  'หญิง',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );
  Widget dadRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            //width: 250.0,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: 'dad',
                  groupValue: contact,
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                ),
                Text(
                  'บิดา',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );
  Widget momRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            //width: 250.0,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: 'mom',
                  groupValue: contact,
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                ),
                Text(
                  'มารดา',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );
  Widget childRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            //width: 250.0,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: 'child',
                  groupValue: contact,
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                ),
                Text(
                  'บุตร',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );
  Widget wifeRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            //width: 250.0,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: 'wife',
                  groupValue: contact,
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                ),
                Text(
                  'ภรรยา',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget husbandRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            //width: 250.0,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: 'husband',
                  groupValue: contact,
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                ),
                Text(
                  'สามี',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget relativeRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            //width: 250.0,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: 'relative',
                  groupValue: contact,
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                ),
                Text(
                  'ญาติ',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget parentRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            //width: 250.0,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: 'parent',
                  groupValue: contact,
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                ),
                Text(
                  'ผู้ปกครอง',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget bossRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            //width: 250.0,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: 'boss',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
                Text(
                  'นายจ้าง',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget friendRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            //width: 250.0,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: 'friend',
                  groupValue: contact,
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                ),
                Text(
                  'เพื่อน',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget etcRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            //width: 250.0,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: 'etc',
                  groupValue: contact,
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                ),
                Text(
                  'อื่นๆโปรดระบุ',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Text txt14B(String subtitle) => Text(
        subtitle,
        style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontFamily: 'BaiJamjuree'),
      );

  Padding textSubtitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          txt14B(title),
        ],
      ),
    );
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => firstName = value.trim(),
=======
                  onChanged: (value) => paramFirstName = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: '$paramId',
=======
                    labelText: '$paramFirstName',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget surnameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => lastName = value.trim(),
=======
                  onChanged: (value) => paramLastName = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: '$paramFirstName',
=======
                    labelText: '$paramLastName',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );
  Row groupButton() {
    return Row(
      children: <Widget>[
<<<<<<< HEAD
        registerButton(),
=======
        editButton(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
        MyStyle().mySizebox(),
        backButton(),
      ],
    );
  }

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

<<<<<<< HEAD
  Widget registerButton() => Container(
=======
  Widget editButton() => Container(
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
        width: MediaQuery.of(context).size.width * 0.4,
        height: 48.0,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: MyStyle().mainColor,
            onPressed: () {
              // print(
              //     'name = $firstName, lastName= $lastName,password =$password');
              // if (firstName == null || firstName.isEmpty) {
              //   print(
              //       //ถ้ากรอกข้อมูลบน textfield ไปแล้วมันจะไม่เป็น null จะเป็น empty แทน
              //       'Have Space');
              //   normalDialog(context, 'มีช่องว่างค่ะ กรุณากรอกทุกช่อง');
              //   // } else if (chooseType == null) {
              //   //   normalDialog(context, 'โปรดเลือกชนิดของผู้สมัคร');
              // } else {
              //   registerThread();
              //   uploadImage();
              //   backDialog(context, 'ลงทะเบียนสำเร็จ', PatientInfo());
              //   print('suscess');
              //   registerSuscess();
                
              // }
              updatePatient();
            },
            child: Text(
              'แก้ไข',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'BaiJamjuree',
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            )),
      );

  SimpleDialog registerSuscess() {
    return SimpleDialog(
                title: Text('ลงทะเบียนสำเร็จ'),
                // Pop จะกลับไปยัง state เดิม
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        onPressed: () {
                          MaterialPageRoute route = MaterialPageRoute(
                              builder: (value) => Home()); //วิธีเชื่อมหน้า
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              );
  }
  Future<Null> updateThread() async {
    //String url = 'http://127.0.0.1:8080/DeliveryFood/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&ChooseType=$chooseType';

    String urlServer =
        'http://restaurant2019.com/htdocs/addPatient.php?isAdd=true&Img=$img&FirstName=$firstName&Age=$age&Disease=$disease&LastName=$lastName&Gender=$gender&Identity=$identity&DateOfBirth=$dateOfBirth&Career=$career&Nationality=$nationality&Religion=$religion&BloodGroup=$bloodGroup&Address=$address&Tel=$tel&NameOfMom=$nameOfMom&NameOfDad=$nameOfDad&NameEmergency=$nameEmergency&AddressEmergency=$addressEmergency&TelEmergency=$telEmergency&Etc=$etc&HistoryAllergy=$historyAllergy';

    try {
      // await ต้องอยู่ใน async เท่านั้นถึงจะทำงานได้
      Response response = await Dio().get(urlServer);
      print('res =$response');
      print('url : $urlServer');
    } catch (e) {
      print('Error');
    }
  }

  Future<Null> registerThread() async {
    //String url = 'http://127.0.0.1:8080/DeliveryFood/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&ChooseType=$chooseType';

    String urlServer =
        'http://restaurant2019.com/htdocs/addPatient.php?isAdd=true&Img=$img&FirstName=$firstName&Age=$age&Disease=$disease&LastName=$lastName&Gender=$gender&Identity=$identity&DateOfBirth=$dateOfBirth&Career=$career&Nationality=$nationality&Religion=$religion&BloodGroup=$bloodGroup&Address=$address&Tel=$tel&NameOfMom=$nameOfMom&NameOfDad=$nameOfDad&NameEmergency=$nameEmergency&AddressEmergency=$addressEmergency&TelEmergency=$telEmergency&Etc=$etc&HistoryAllergy=$historyAllergy';

    try {
      // await ต้องอยู่ใน async เท่านั้นถึงจะทำงานได้
      Response response = await Dio().get(urlServer);
      print('res =$response');
      print('url : $urlServer');
    } catch (e) {
      print('Error');
    }
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'Img$i.jpg';

    print('nameImage = $nameImage, pathImage =${file.path}');
    String url = '${MyConstant().domain}/htdocs/uploadPhoto.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) { 
        print('Response -> $value');
        urlImage = '${MyConstant().domain}/htdocs/photo/$nameImage';
        print('urlImage = $urlImage' );
      });
    } catch (e) {
      print(e);
    }
  }

  Widget identityForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => identity = value.trim(),
=======
                  onChanged: (value) => paramIdentity = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: '$paramLastName',
=======
                    labelText: '$paramIdentity',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget dateOfBirthForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => dateOfBirth = value.trim(),
=======
                  onChanged: (value) => paramDateOfBirth = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'วัน / เดือน / ปี ที่เกิด',
=======
                    labelText: '$paramDateOfBirth',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget ageForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => age = value.trim(),
=======
                  onChanged: (value) => paramAge = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'อายุ',
=======
                    labelText: '$paramAge',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget diseaseForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => disease = value.trim(),
=======
                  onChanged: (value) => paramDisease = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'โรคประจำตัว',
=======
                    labelText: '$paramDisease',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget careerForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => career = value.trim(),
=======
                  onChanged: (value) => paramCareer = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'อาชีพ',
=======
                    labelText: '$paramCareer',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget nationalityForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => nationality = value.trim(),
=======
                  onChanged: (value) => paramNationality = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'สัญชาติ',
=======
                    labelText: '$paramNationality',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget religionForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => religion = value.trim(),
=======
                  onChanged: (value) => paramNationality = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'ศาสนา',
=======
                    labelText: '$paramReligion',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget bloodGroupForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => bloodGroup = value.trim(),
=======
                  onChanged: (value) => paramBloodGroup = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'หมู่เลือด',
=======
                    labelText: '$paramBloodGroup',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget addressForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => address = value.trim(),
=======
                  onChanged: (value) => paramAddress = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'ที่อยู่ปัจจุบัน',
=======
                    labelText: '$paramAddress',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget telForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => tel = value.trim(),
=======
                  onChanged: (value) => paramTel = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'เบอร์โทรศัพท์',
=======
                    labelText: '$paramTel',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget nameDadForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => nameOfDad = value.trim(),
=======
                  onChanged: (value) => paramNameOfDad = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'ชื่อ - นามสกุล บิดา',
=======
                    labelText: '$paramNameOfDad',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget nameMomForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => nameOfMom = value.trim(),
=======
                  onChanged: (value) => paramNameOfMom = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'ชื่อ - นามสกุล มารดา',
=======
                    labelText: '$paramNameOfMom',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );
<<<<<<< HEAD

=======
//NameEmergency
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
  Widget emergencyContactForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => nameEmergency = value.trim(),
=======
                  onChanged: (value) => paramNameEmergency = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'ผู้ติดต่อได้ในกรณีฉุกเฉิน',
=======
                    labelText: '$paramNameEmergency',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget emergencyAddressForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => addressEmergency = value.trim(),
=======
                  onChanged: (value) => paramAddressEmergency = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'ที่อยู่ผู้ติดต่อได้',
=======
                    labelText: '$paramAddressEmergency',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget emergencyTelForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => telEmergency = value.trim(),
=======
                  onChanged: (value) => paramTelEmergency = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'เบอร์โทรศัพท์ผู้ติดต่อได้กรณีฉุกเฉิน',
=======
                    labelText: '$paramTelEmergency',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget etcForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => etc = value.trim(),
=======
                  onChanged: (value) => paramEtc = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'อื่นๆโปรดระบุ',
=======
                    labelText: '$paramEtc',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget drugAllergyForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.83,
              height: 48,
              child: TextField(
<<<<<<< HEAD
                  onChanged: (value) => historyAllergy = value.trim(),
=======
                  onChanged: (value) => paramHistoryAllergy = value.trim(),
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
<<<<<<< HEAD
                    labelText: 'ชื่อ',
=======
                    labelText: '$paramHistoryAllergy',
>>>>>>> 45402bbaf6f816739e66a5de9b90c9ba458f5e07
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );
}
