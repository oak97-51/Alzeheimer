import 'dart:convert';

import 'package:Alzeheimer/data/model_user.dart';
// import 'package:Alzeheimer/screens/home.dart';
import 'package:Alzeheimer/screens/home2.dart';
import 'package:Alzeheimer/screens/signup.dart';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:Alzeheimer/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   //title: Text('Sign In'),
      // ),
      backgroundColor: MyStyle().mainColor,
      body: Center(
          child: SingleChildScrollView(
        //ทำให้คีย์บอร์ดไม่บัค scroll ได้
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MyStyle().showLogo(),
            MyStyle().showTitle('Tracking & Take care'),
            MyStyle().showSubtitle('Amnesia Patient'),
            MyStyle().mySizebox(),
            mainBorder(context),
          ],
        ),
      )),
    );
  }

  Container mainBorder(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          MyStyle().mySizebox(),
          MyStyle().showSubtitle2('เข้าสู่ระบบ'),
          //container(),
          MyStyle().mySizebox(),
          userForm(),
          MyStyle().mySizebox(),
          passwordForm(),
          MyStyle().mySizebox(),
          loginButton(),
          MyStyle().mySizebox(),
          registerMethod(),
        ],
      ),
    );
  }

  Container registerMethod() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ยังไม่ได้เป็นสมาชิก?     ',
            style: TextStyle(
              fontSize: 16.0,
              color: MyStyle().mainColor,
              fontWeight: FontWeight.normal,
              fontFamily: 'BaiJamjuree',
            ),
          ),
          InkWell(
            onTap: () {
              //Navigator.pop(context); // ลูกศรกลับ แก้ปัญหาเรื่องตัว Drawer ไม่หดกลับ
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => SignUp()); //วิธีเชื่อมหน้า
              Navigator.push(context, route);
            },
            child: new Text("ลงทะเบียน",
                style: TextStyle(
                  color: MyStyle().mainColor,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                  fontFamily: 'BaiJamjuree',
                )),
          )
        ],
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String url =
        'http://restaurant2019.com/htdocs/checkAuthen.php?isAdd=true&Email=$email';
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result =
          json.decode(response.data); //ตัวแปร var คือไม่รู้ว่าได้ค่ามาเป็นอะไร
      print('result = $result');

      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        print("error");
        if (password == userModel.password) {
          routeToService(Home2(), userModel);
          // String chooseType = userModel.chooseType;
          //   if(chooseType == 'User'){
          //     routeToService(MainUser(),userModel);
          //   }else if(chooseType == 'Shop'){
          //     routeToService(MainShop(),userModel);
          //   }else if(chooseType == 'Rider'){
          //     routeToService(MainRider(),userModel);
          //   }else{
          //     normalDialog(context,'ข้อมูลของท่านไม่ตรงกับที่สมัคร');
          //   }
        } else {
          normalDialog(context, 'Password ผิด กรอกใหม่อีกครั้ง');
        }
      }
    } catch (e) {
      print('error');
      normalDialog(context, 'Email หรือ Password ผิด กรุณากรอกใหม่อีกครั้ง');
    }
  }

  Future<Null> routeToService(Widget myWidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.adminId);
    preferences.setString('Email', userModel.email);
    preferences.setString('LastName', userModel.lastName);
    preferences.setString('FirstName', userModel.firstName);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget userForm() => Container(
      width: 340.0,
      height: 48.0,
      child: TextField(
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            //prefixIcon: Icon(Icons.account_box, color: MyStyle().darkColor),
            labelStyle: TextStyle(
              color: Color(0xFF6D7278),
              fontFamily: 'BaiJamjuree',
            ),
            labelText: 'อีเมล',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          )));

  Widget passwordForm() => Container(
      width: 340.0,
      height: 48.0,
      child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true, // ทำ password เป็น ****
          decoration: InputDecoration(
            //prefixIcon: Icon(Icons.lock, color: MyStyle().darkColor),
            labelStyle: TextStyle(
              color: Color(0xFF6D7278),
              fontFamily: 'BaiJamjuree',
            ),
            labelText: 'รหัสผ่าน : ',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          )));

  Widget textWidget(String text) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding:
          const EdgeInsets.all(10.0), //             <--- BoxDecoration here
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );
  }

  Widget loginButton() => Container(
        width: 340.0,
        height: 48.0,
        child: RaisedButton(
          color: MyStyle().mainColor,
          onPressed: () {
            if (email == null ||
                email.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'มีช่องว่างกรุณากรอกให้ครบ');
            } else {
              checkAuthen();
            }
            // MaterialPageRoute route = MaterialPageRoute(
            //       builder: (value) => Home()); //วิธีเชื่อมหน้า
            //   Navigator.push(context, route);
          },
          child: Text(
            'เข้าสู่ระบบ',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'BaiJamjuree',
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      );
}
