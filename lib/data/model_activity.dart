class ActivityModel {
  String id;
  String patientId;
  String at_date;
  String at_time;
  String description;
  String drug;
  String status;
  String remark;
  String total;
  String size;


  ActivityModel(
      this.id,
      this.patientId,
      this.at_date,
      this.at_time,
      this.description,
      this.drug,
      this.status,
      this.remark,
      this.total,
      this.size,
      );

  ActivityModel.fromMap(Map<String, dynamic> map) {
    
    id = map['id'];
    patientId = map['patient_id'];
    at_date = map['at_date'];
    at_time = map['at_time'];
    description = map['description'];
    drug = map['drug'];
    status = map['status'];
    remark = map['remark'];
    total = map['total'];
    size = map['size'];
  }
}