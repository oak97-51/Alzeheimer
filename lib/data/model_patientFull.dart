class PatientModelFull {
  String patientId;
  String img;
  String name;
  String age;
  String disease;

  PatientModelFull(
    this.patientId,
    this.img,
    this.name,
    this.age,
    this.disease,
  );

  PatientModelFull.fromMap(Map<String, dynamic> map) {
    patientId = map['PatientId'];
    img = map['Img'];
    name = map['FirstName'];
    age = map['Age'];
    disease = map['Disease'];
  }
}