class TrackingModel {
  String id;
  String patientId;
  String lat;
  String lng;
  String cdatetime;

  TrackingModel({
    this.id,
    this.patientId,
    this.lat,
    this.lng,
    this.cdatetime,
  });

  TrackingModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    patientId = map['patient_id'];
    lat = map['lat'];
    lng = map['lng'];
    cdatetime = map['cdatetime'];
  }

  Map<String, dynamic> tomap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['cdatetime'] = this.cdatetime;
    return data;
  }
}
