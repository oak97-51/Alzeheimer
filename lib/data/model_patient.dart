class PatientModel {
  String patientId;
  String img;
  String name;
  String age;
  String disease;

  PatientModel(
    this.patientId,
    this.img,
    this.name,
    this.age,
    this.disease,
  );

  PatientModel.fromMap(Map<String, dynamic> map) {
    patientId = map['PatientId'];
    img = map['Img'];
    name = map['FirstName'];
    age = map['Age'];
    disease = map['Disease'];
  }
}

// class PatientModel {
//   String patientId;
//   String img;
//   String name;
//   String age;
//   String disease;

//   PatientModel(
//     {this.patientId,
//     this.img,
//     this.name,
//     this.age,
//     this.disease,}
//   );

//   PatientModel.fromJson(Map<String, dynamic> json) {
//     patientId = json['PatientId'];
//     img = json['Img'];
//     name = json['FirstName'];
//     age = json['Age'];
//     disease = json['Disease'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['PatientId'] = this.patientId;
//     data['Img'] = this.img;
//     data['FirstName'] = this.name;
//     data['Age'] = this.age;
//     data['Disease'] = this.disease;
//     return data;
//   }
// }


