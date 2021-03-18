class PatientByIDModel2 {
  String patientId;
  String img;
  String firstName;
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

  PatientByIDModel2(
      this.patientId,
      this.img,
      this.firstName,
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

  PatientByIDModel2.fromMap(Map<String, dynamic> map) {
    patientId = map['PatientId'];
    img = map['Img'];
    firstName = map['FirstName'];
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

  // Map<String, dynamic> tomap() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['PatientId'] = this.patientId;
  //   data['Img'] = this.img;
  //   data['FirstName'] = this.firstName;
  //   data['Age'] = this.age;
  //   data['Disease'] = this.disease;
  //   data['LastName'] = this.lastName;
  //   data['Gender'] = this.gender;
  //   data['Identity'] = this.identity;
  //   data['DateOfBirth'] = this.dateOfBirth;
  //   data['Career'] = this.career;
  //   data['Nationality'] = this.nationality;
  //   data['Religion'] = this.religion;
  //   data['BloodGroup'] = this.bloodGroup;
  //   data['Address'] = this.address;
  //   data['Tel'] = this.tel;
  //   data['NameOfMom'] = this.nameOfMom;
  //   data['NameOfDad'] = this.nameOfDad;
  //   data['NameEmergency'] = this.nameEmergency;
  //   data['AddressEmergency'] = this.addressEmergency;
  //   data['TelEmergency'] = this.telEmergency;
  //   data['Etc'] = this.etc;
  //   data['HistoryAllergy'] = this.historyAllergy;
  //   return data;
  // }
}

