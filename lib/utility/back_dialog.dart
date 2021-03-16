// import 'package:Alzeheimer/screens/signin.dart';
import 'package:flutter/material.dart';

Future<void> backDialog(
    BuildContext context, String message, Widget widget) async {
  showDialog(
    context: context,
    // Title ต้องเป็น widget
    builder: (context) => SimpleDialog(
      title: Text(message),
      // Pop จะกลับไปยัง state เดิม
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (value) => widget); //วิธีเชื่อมหน้า
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
    ),
  );
}
