class PatientModel {
  String patientId;
  String img;
  String name;
  String age;
  String disease;
  String lastName;
  String gender;
  String identity;
  String dateOfBirth;
  String career;
  String nationality;
  String religion;
  String bloodGroup;
  String address;
  String tel;
  String nameOfMom;
  String nameOfDad;
  String nameEmergency;
  String addressEmergency;
  String telEmergency;
  String etc;
  String historyAllergy;

  PatientModel(
      this.patientId,
      this.img,
      this.name,
      this.age,
      this.disease,
      this.lastName,
      this.gender,
      this.identity,
      this.dateOfBirth,
      this.career,
      this.nationality,
      this.religion,
      this.bloodGroup,
      this.address,
      this.tel,
      this.nameOfMom,
      this.nameOfDad,
      this.nameEmergency,
      this.addressEmergency,
      this.telEmergency,
      this.etc,
      this.historyAllergy);

  PatientModel.fromMap(Map<String, dynamic> map) {
    patientId = map['PatientId'];
    img = map['Img'];
    name = map['FirstName'];
    age = map['Age'];
    disease = map['Disease'];
    lastName = map['LastName'];
    gender = map['Gender'];
    identity = map['Identity'];
    dateOfBirth = map['DateOfBirth'];
    career = map['Career'];
    nationality = map['Nationality'];
    religion = map['Religion'];
    bloodGroup = map['BloodGroup'];
    address = map['Address'];
    tel = map['Tel'];
    nameOfMom = map['NameOfMom'];
    nameOfDad = map['NameOfDad'];
    nameEmergency = map['NameEmergency'];
    addressEmergency = map['AddressEmergency'];
    telEmergency = map['TelEmergency'];
    etc = map['Etc'];
    historyAllergy = map['HistoryAllergy'];
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
