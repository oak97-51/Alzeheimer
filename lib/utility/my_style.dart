import 'package:flutter/material.dart';

class MyStyle{

  Color darkColor = Colors.blueGrey;
  Color primaryColor = Colors.blue.shade200;
  Color mainColor = Color(0xFF2A2AC0);

  SizedBox mySizebox() => SizedBox(width: 8.0,height: 16.0,);
  SizedBox mySizeboxw24() => SizedBox(width: 24.0,height: 16.0,);
  SizedBox mySizeboxh24() => SizedBox(width: 8.0,height: 24.0,);
  SizedBox freeSizebox(double w,double h) => SizedBox(width: w,height: h,);

  Text showTitle(String title) => Text(title,style: TextStyle(fontSize: 16.0,color: Colors.white,fontWeight: FontWeight.bold),);
  Text showSubtitle(String subtitle) => Text(subtitle,style: TextStyle(fontSize: 16.0,color: Colors.white70,fontWeight: FontWeight.normal,fontFamily: 'BaiJamjuree'),);
  Text showSubtitle2(String subtitle) => Text(subtitle,style: TextStyle(fontSize: 16.0,color: mainColor,fontWeight: FontWeight.normal,fontFamily: 'BaiJamjuree'),);
  Text txt16Bold(String subtitle) => Text(subtitle,style: TextStyle(fontSize: 16.0,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'BaiJamjuree'),);
  Text txt20RegularB(String subtitle) => Text(subtitle,style: TextStyle(fontSize: 20.0,color: Colors.black,fontWeight: FontWeight.normal,fontFamily: 'BaiJamjuree'),);
  Text txt16BoldMain(String subtitle) => Text(subtitle,style: TextStyle(fontSize: 16.0,color: mainColor,fontWeight: FontWeight.w600,fontFamily: 'BaiJamjuree'),);
  Text txt16BoldB(String subtitle) => Text(subtitle,style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.w600,fontFamily: 'BaiJamjuree'),);

  Container showLogo() {
    return Container(
            width: 120,
            height: 120,
            child: Image.asset('images/logo_heart.png'));
  }

  MyStyle();
}