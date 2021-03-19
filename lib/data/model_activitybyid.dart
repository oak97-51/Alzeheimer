class ActivityByIDModel {
  String id;
  String patientId;
  String atdate;
  String attime;
  String description;
  String drug;
  String status;
  String remark;

  ActivityByIDModel({
    this.id,
    this.patientId,
    this.atdate,
    this.attime,
    this.description,
    this.drug,
    this.status,
    this.remark,
  });

  ActivityByIDModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    patientId = map['patient_id'];
    atdate = map['at_date'];
    attime = map['at_time'];
    description = map['description'];
    drug = map['drug'];
    status = map['status'];
    remark = map['remark'];
  }

  Map<String, dynamic> tomap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['at_date'] = this.atdate;
    data['at_time'] = this.attime;
    data['description'] = this.description;
    data['drug'] = this.drug;
    data['status'] = this.status;
    data['remark'] = this.remark;

    return data;
  }
}
