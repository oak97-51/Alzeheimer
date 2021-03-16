import 'package:Alzeheimer/screens/signin.dart';
import 'package:Alzeheimer/screens/uploadImageDemo.dart';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ScreenPage extends StatefulWidget {
  @override
  _ScreenPageState createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => SignIn()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [-1, 0.6, 0.8, 1],
            // ตรงกลางคือ 0.0 บนคือ -1 ข้างล่าง +1 ซ้าย -1 ขวา +1
            colors: [
              Color(0xFF2A2AC0),
              Color(0xFF1F1C84),
              //Colors.black,
              Color(0xFF1C1976),
              Color(0xFF181461)
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyStyle().showLogo(),
              MyStyle().showTitle('Tracking & Take care'),
              MyStyle().showSubtitle('Amnesia Patient'),
              MyStyle().freeSizebox(0, 100),
              CircularProgressIndicator(
                // strokeWidth: 10,
                //backgroundColor: Colors.cyanAccent,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
