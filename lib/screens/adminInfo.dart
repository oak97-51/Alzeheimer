import 'package:Alzeheimer/data/model_user.dart';
import 'package:Alzeheimer/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminInfo extends StatefulWidget {
  @override
  _AdminInfoState createState() => _AdminInfoState();
}

class _AdminInfoState extends State<AdminInfo> {
  String firstName,
      lastName,
      password,
      confirmPassword,
      gender,
      dateOfBirth,
      department,
      bloodType,
      address,
      email,
      img;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminPreferences();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyStyle().txt16Bold('ประวัติส่วนตัว'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: MyStyle().mainColor,
        centerTitle: true,
      ),
      body: Container(alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                photoAdmin(),
                nameText(),
                departmentText(),
                dateOfBirthText(),
                genderText(),
                bloodTypeText(),
                addressText(),
              ],
            )
          ],
        ),
      ),
    );
  }
  // Future<Null> routeToService(Widget myWidget, UserModel userModel) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('LastName',userModel.lastName);
  //   preferences.setString('FirstName',userModel.firstName);
  //   preferences.setString('Department',userModel.department);
  //   preferences.setString('DateOfBirth',userModel.dateOfBirth);
  //   preferences.setString('Gender',userModel.gender);
  //   preferences.setString('BloodType',userModel.bloodType);
  //   preferences.setString('Address',userModel.address);

  //   MaterialPageRoute route = MaterialPageRoute (builder: (context) => myWidget,);
  //   Navigator.pushAndRemoveUntil(context,route,(route)=>false);
  // }

   Future<Null> adminPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      firstName = preferences.getString('FirstName');
      lastName = preferences.getString('LastName');
      department = preferences.getString('Department');
      dateOfBirth = preferences.getString('DateOfBirth');
      gender = preferences.getString('Gender');
      bloodType = preferences.getString('BloodType');
      address = preferences.getString('Address');
      img = preferences.getString('Img');
      email = preferences.getString('Email');
      print('Nameuser = $gender');
    });
  }

  Container photoAdmin() {
    return Container(
                height: 300,
                width: 200,
                // child: Image(image: NetworkImage('${patientModels[index].img}'),)
                child: Image.asset('images/middle_age_man.png'),
              );
  }

  Text nameText() => Text('ชื่อนามสกุล : $firstName $lastName');
  Text departmentText() => Text('ตำแหน่ง : $department');
  Text dateOfBirthText() => Text('วัน / เดือน / ปี ที่เกิด : $dateOfBirth');
  Text genderText() => Text('เพศ : $email');
  Text bloodTypeText() => Text('หมู่เลือด : $bloodType');
  Text addressText() => Text('ที่อยู่ : $address');
}
