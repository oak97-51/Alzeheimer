class UserModel {
  String adminId;
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  String gender;
  String dateOfBirth;
  String department;
  String bloodType;
  String address;
  String img;
  String idp;
  String status;

  UserModel({
    this.adminId,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    this.gender,
    this.dateOfBirth,
    this.department,
    this.bloodType,
    this.address,
    this.img,
    this.idp,
    this.status,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    adminId = json['Admin_Id'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    password = json['Password'];
    confirmPassword = json['ConfirmPassword'];
    gender = json['Gender'];
    dateOfBirth = json['DateOfBirth'];
    department = json['Department'];
    bloodType = json['BloodType'];
    address = json['Address'];
    img = json['Img'];
    idp = json['idp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Admin_Id'] = this.adminId;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['ConfirmPassword'] = this.confirmPassword;
    data['Gender'] = this.gender;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Department'] = this.department;
    data['BloodType'] = this.bloodType;
    data['Address'] = this.address;
    data['Img'] = this.img;
    data['idp'] = this.idp;
    data['status'] = this.status;
    return data;
  }
}
