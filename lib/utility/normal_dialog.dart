import 'package:flutter/material.dart';

//ใช้เป็น Thread (Future) เพราะว่า ถ้า dialog ทำงานจะทำให้ state หยุดการทำงานชั่วคราว
Future<void> normalDialog(BuildContext context, String message) async {
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
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
