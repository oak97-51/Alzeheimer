import 'package:Alzeheimer/screens/screenpage.dart';
//import 'package:Alzeheimer/screens/singleImageUpload.dart';
import 'package:flutter/material.dart';

//แบบย่อ
main()=>runApp(MyApp());
//แบบเต็ม
// void main(){
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracking & Take care',
      home: ScreenPage(),
    );
  }
}

