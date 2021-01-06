class ReportModel {
  bool success;
  List<Sample> data;
  String message;

  ReportModel({this.success, this.data, this.message});

  ReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Sample>();
      json['data'].forEach((v) {
        data.add(new Sample.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Sample {
  int id;
  int statusLacak;
  String paket;
  String barcode;
  String personId;
  String timeOfRegistration;
  String receivedDate;
  List<Detail> detail;

  Sample(
      {this.id,
        this.statusLacak,
        this.paket,
        this.barcode,
        this.personId,
        this.timeOfRegistration,
        this.receivedDate,
        this.detail});

  Sample.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusLacak = json['status_lacak'];
    paket = json['paket'];
    barcode = json['barcode'];
    personId = json['person_id'];
    timeOfRegistration = json['time_of_registration'];
    receivedDate = json['received_date'];
    if (json['detail'] != null) {
      detail = new List<Detail>();
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status_lacak'] = this.statusLacak;
    data['paket'] = this.paket;
    data['barcode'] = this.barcode;
    data['person_id'] = this.personId;
    data['time_of_registration'] = this.timeOfRegistration;
    data['received_date'] = this.receivedDate;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  int sampelId;
  String serviceName;
  String reportId;
  String reportStatus;

  Detail({this.sampelId, this.serviceName, this.reportId, this.reportStatus});

  Detail.fromJson(Map<String, dynamic> json) {
    sampelId = json['sampel_id'];
    serviceName = json['service_name'];
    reportId = json['report_id'];
    reportStatus = json['report_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sampel_id'] = this.sampelId;
    data['service_name'] = this.serviceName;
    data['report_id'] = this.reportId;
    data['report_status'] = this.reportStatus;
    return data;
  }
}
