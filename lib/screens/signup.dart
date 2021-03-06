import 'dart:io';

import 'package:Alzeheimer/screens/signin.dart';
import 'package:Alzeheimer/utility/back_dialog.dart';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:Alzeheimer/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String firstName,
      lastName,
      password,
      confirmPassword,
      gender,
      dateOfBirth,
      department,
      bloodType,
      address,
      email;
  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: MyStyle().txt16Bold('ลงทะเบียน'),
        backgroundColor: MyStyle().mainColor,
        centerTitle: true,
      ),
      //ต้องหา row,container ไปครอบเพื่อจัดขนาดใน listview
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
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
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      MyStyle().mySizebox(),
                      MyStyle().txt20RegularB('ข้อมูลบัญชีผู้ใช้'),
                      MyStyle().mySizebox(),
                      textSubtitle('ชื่อ'),
                      firstNameForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('นามสกุล'),
                      lastNameForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('อีเมล'),
                      emailForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('รหัสผ่าน'),
                      passwordForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('ยืนยันรหัสผ่าน'),
                      confirmpasswordForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('เพศ'),
                      Row(
                        children: [
                          genderManRadio(),
                          genderWomanRadio(),
                        ],
                      ),
                      MyStyle().mySizebox(),
                      textSubtitle('วัน / เดือน / ปี'),
                      dateOfBirthForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('ตำแหน่ง'),
                      departmentForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('หมุ่เลือด'),
                      bloodTypeForm(),
                      MyStyle().mySizebox(),
                      textSubtitle('ที่อยู่'),
                      addressForm(),
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
              MyStyle().mySizeboxh24(),
              Row(
                children: [
                  MyStyle().mySizeboxw24(),
                  backButton(),
                  MyStyle().mySizeboxw24(),
                  registerButton(),
                ],
              ),
              MyStyle().mySizeboxh24(),
            ],
          ),
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

  Widget firstNameForm() => Row(
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

  Widget lastNameForm() => Row(
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

  Widget emailForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => email = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'อีเมล',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => password = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'รหัสผ่าน',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget confirmpasswordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => confirmPassword = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'ยืนยันรหัสผ่าน',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget departmentForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => department = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyStyle().darkColor,
                        fontFamily: 'BaiJamjuree',
                        fontSize: 16),
                    labelText: 'ตำแหน่ง',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                  ))),
        ],
      );

  Widget bloodTypeForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //margin: const EdgeInsets.only(),
              width: 340.0,
              height: 48,
              child: TextField(
                  onChanged: (value) => bloodType = value.trim(),
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
        children: <Widget>[
          Container(
              //margin: const EdgeInsets.only(),
              width: 340.0,
              height: 48.0,
              child: TextField(
                  //maxLines: 4,
                  onChanged: (value) => address = value.trim(),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: MyStyle().darkColor,
                      fontFamily: 'BaiJamjuree',
                      fontSize: 16,
                    ),
                    labelText: 'ที่อยู่',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyStyle().primaryColor)),
                    fillColor: Color(0xFFF3F5F8),
                    filled: true,
                    //contentPadding: EdgeInsets.only(left: 10,top: 100),
                  ))),
          SizedBox(
            height: 50,
          ),
        ],
      );

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
                  'firstName = $firstName, lastName= $lastName,email=$email,password =$password,confirmPassword,=$confirmPassword,gender=$gender,dateOfBirth=$dateOfBirth,department=$department,bloodType=$bloodType,address=$address');
              if (firstName == null ||
                  firstName.isEmpty ||
                  lastName == null ||
                  lastName.isEmpty ||
                  password == null ||
                  password.isEmpty) {
                print(
                    //ถ้ากรอกข้อมูลบน textfield ไปแล้วมันจะไม่เป็น null จะเป็น empty แทน
                    'Have Space');
                normalDialog(context, 'มีช่องว่างค่ะ กรุณากรอกทุกช่อง');
              } else if (gender == null) {
                normalDialog(context, 'โปรดเลือกชนิดของผู้สมัคร');
              } else {
                registerThread();
                backDialog(context,'ลงทะเบียนสำเร็จ',SignIn());
                // normalDialog(context, 'ลงทะเบียนสำเร็จ');
                // MaterialPageRoute route = MaterialPageRoute(
                //     builder: (value) => SignIn()); //วิธีเชื่อมหน้า
                // Navigator.push(context, route);
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
  //Method จะทำงานโดยไม่สนใจผล Thread จะทำงานสนใจผลลัพท์ (รอผลลัพท์)
  Future<Null> registerThread() async {
    //String url = 'http://127.0.0.1:8080/DeliveryFood/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&ChooseType=$chooseType';
    String urlServer =
        'http://restaurant2019.com/htdocs/addUser.php?isAdd=true&FirstName=$firstName&LastName=$lastName&Email=$email&Password=$password&Gender=$gender&DateOfBirth=$dateOfBirth&Department=$department&BloodType=$bloodType&Address=$address';
    // String url ='http://192.168.64.2/DeliveryFood/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&ChooseType=$chooseType';
    try {
      // await ต้องอยู่ใน async เท่านั้นถึงจะทำงานได้
      Response response = await Dio().get(urlServer);
      print('res =$response');
      print('url : $urlServer');
    } catch (e) {
      print('Error');
    }
  }

  Row showAppname() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyStyle().showTitle('Delivery Food'),
      ],
    );
  }

  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyStyle().showLogo(),
        ],
      );
}
