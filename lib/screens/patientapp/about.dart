import 'package:flutter/material.dart';
import 'package:Alzeheimer/utility/my_style.dart';

class Aboutapp2 extends StatefulWidget {
  Aboutapp2({Key key}) : super(key: key);

  @override
  _Aboutapp2State createState() => _Aboutapp2State();
}

class _Aboutapp2State extends State<Aboutapp2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เกี่ยวกับแอพพลิเคชั่น'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MyStyle().freeSizebox(0, 25),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('    แอพพลิเคชั่นนี้ทำเพื่อให้ผู้ป่วยอัลไซเมอร์ ,')
              ],
            ),
            Row(
              children: <Widget>[
                Text('    ผู้สูงอายุใช้แจ้งเตือนความจำกิจกรรมที่ต้องทำ')
              ],
            ),
            Row(
              children: <Widget>[Text('    ในแต่ละวัน,เตือนกินยาในแต่ละวัน')],
            ),
            Row(
              children: <Widget>[Text('    และป้องกันผู้ป่่วยสูญหาย')],
            ),
            MyStyle().freeSizebox(0, 25),
            Row(
              children: <Widget>[Text('    วิธีใช้งาน')],
            ),
            MyStyle().freeSizebox(0, 14),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('      ปุ่ม'),
                    Container(
                      width: MediaQuery.of(context).size.width / 6.5,
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset('images/patientapp-person.png')),
                    ),
                    Text('  กดเพื่อดูประวัติส่วนตัวของผู้ป่วย'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('      ปุ่ม'),
                    Container(
                      width: MediaQuery.of(context).size.width / 6.5,
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset('images/patientapp-current.png')),
                    ),
                    Column(
                      children: <Widget>[
                        Text('  กดเพื่อแสดงตำแหน่ง'),
                        Text('  สถานที่ปัจจุบันของผู้ป่วย'),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('      ปุ่ม'),
                    Container(
                      width: MediaQuery.of(context).size.width / 6.5,
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset('images/patientapp-active.png')),
                    ),
                    Column(
                      children: <Widget>[
                        Text('  กดเพื่อแสดงกิจกรรมที่ผู้ป่วย'),
                        Text('  ต้องทำในแต่ละวัน เช่น'),
                        Text('  เตือนกินยา, เตือนทานอาหาร'),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('      ปุ่ม'),
                    Container(
                      width: MediaQuery.of(context).size.width / 6.5,
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset('images/emergency_logo.png')),
                    ),
                    Text('  กดเพื่อโทรหาผู้ดูแลกรณีฉุกเฉิน'),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
