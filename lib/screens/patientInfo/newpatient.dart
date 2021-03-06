import 'dart:io';

import 'package:Alzeheimer/screens/patientInfo/patientInfo.dart';
import 'package:Alzeheimer/utility/back_dialog.dart';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:Alzeheimer/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPatient extends StatefulWidget {
  @override
  _NewPatientState createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
  File file;
  //asdasdasdad
  String chooseType,
      firstName,
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
  String user, password;
  String r_dad,
      r_mom,
      r_child,
      r_wife,
      r_husband,
      r_relative,
      r_parent,
      r_boss,
      r_friend,
      r_etc,
      contact;

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
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: MyStyle().txt16Bold('แบบฟอร์มกรอกเอกสารผู้ป่วยใหม่'),
          backgroundColor: MyStyle().mainColor,
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                //height: screenHeight,
                height: MediaQuery.of(context).size.height* 0.75,
                width: MediaQuery.of(context).size.width * 0.9,
                margin:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
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
                          Row(
                            children: [
                              dadRadio(),
                              momRadio(),
                              childRadio(),
                              wifeRadio(),
                            ],
                          ),
                          Row(
                            children: [
                              husbandRadio(),
                              relativeRadio(),
                              parentRadio(),
                              bossRadio(),
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
                  registerButton(),
                ],
              ),
              MyStyle().mySizebox(),
            ],
          ),
        ),
        );
  }

  Column groupImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: file == null ?Image.asset('images/middle_age_man.png'): Image.file(file),
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
        width: 120.0,
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
        width: 120.0,
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
            width: 100,
            child: Row(
              //setstate ถ้าเลือกแล้วจะวาด state ใหม่ state จะถูกวาดขึ้นมาครั้งเดียวตอนแรก
              children: <Widget>[
                Radio(
                  value: 'man',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
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

  Widget genderWomanRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 250.0,
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => firstName = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'ชื่อ',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => lastName = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'นามสกุล',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );
  Row groupButton(){
    return Row(
      children: <Widget>[
        registerButton(),
        MyStyle().mySizebox(),
        backButton(),
      ],
    );
  }

  Widget backButton() => Container(
        width: 170.0,
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

  Widget registerButton() => Container(
        width: 170.0,
        height: 48.0,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: MyStyle().mainColor,
            onPressed: () {
              print(
                  'name = $firstName, lastName= $lastName,password =$password,chooseType,=$chooseType');
              if (firstName == null || firstName.isEmpty) {
                print(
                    //ถ้ากรอกข้อมูลบน textfield ไปแล้วมันจะไม่เป็น null จะเป็น empty แทน
                    'Have Space');
                normalDialog(context, 'มีช่องว่างค่ะ กรุณากรอกทุกช่อง');
                // } else if (chooseType == null) {
                //   normalDialog(context, 'โปรดเลือกชนิดของผู้สมัคร');
              } else {
                registerThread();
                backDialog(context, 'ลงทะเบียนสำเร็จ', PatientInfo());
              }
            },
            child: Text(
              'ถัดไป',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'BaiJamjuree',
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            )),
      );

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

  Widget identityForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => identity = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'เลขบัตรประชาชน',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => dateOfBirth = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'วัน / เดือน / ปี ที่เกิด',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => age = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'อายุ',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => disease = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'โรคประจำตัว',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => career = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'อาชีพ',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => nationality = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'สัญชาติ',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => religion = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'ศาสนา',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => bloodGroup = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'หมู่เลือด',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => address = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'ที่อยู่ปัจจุบัน',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => tel = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'เบอร์โทรศัพท์',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => nameOfDad = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'ชื่อ - นามสกุล บิดา',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => nameOfMom = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'ชื่อ - นามสกุล มารดา',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget emergencyContactForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => nameEmergency = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'ผู้ติดต่อได้ในกรณีฉุกเฉิน',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => addressEmergency = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'ที่อยู่ผู้ติดต่อได้',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => telEmergency = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'เบอร์โทรศัพท์ผู้ติดต่อได้กรณีฉุกเฉิน',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => etc = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'อื่นๆโปรดระบุ',
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
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => historyAllergy = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'ชื่อ',
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
