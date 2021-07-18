class NewAllPatienCardModel {
  bool success;
  List<DataPatientCard> data;
  String message;

  NewAllPatienCardModel({this.success, this.data, this.message});

  NewAllPatienCardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<DataPatientCard>();
      json['data'].forEach((v) {
        data.add(new DataPatientCard.fromJson(v));
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

class DataPatientCard {
  int id;
  int accountId;
  String noKtp;
  String inssuranceCode;
  String nama;
  String gender;
  String dob;
  String bloodType;
  String medicalProfesional;
  String emergencyContact;
  String comorbidity;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String photo;
  String weight;
  String height;

  DataPatientCard(
      {this.id,
        this.accountId,
        this.noKtp,
        this.inssuranceCode,
        this.nama,
        this.gender,
        this.dob,
        this.bloodType,
        this.medicalProfesional,
        this.emergencyContact,
        this.comorbidity,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.photo,
        this.weight,
        this.height});

  DataPatientCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    noKtp = json['no_ktp'];
    inssuranceCode = json['inssurance_code'];
    nama = json['nama'];
    gender = json['gender'];
    dob = json['dob'];
    bloodType = json['blood_type'];
    medicalProfesional = json['medical_profesional'];
    emergencyContact = json['emergency_contact'];
    comorbidity = json['comorbidity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    photo = json['photo'];
    weight = json['weight'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_id'] = this.accountId;
    data['no_ktp'] = this.noKtp;
    data['inssurance_code'] = this.inssuranceCode;
    data['nama'] = this.nama;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['blood_type'] = this.bloodType;
    data['medical_profesional'] = this.medicalProfesional;
    data['emergency_contact'] = this.emergencyContact;
    data['comorbidity'] = this.comorbidity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['photo'] = this.photo;
    data['weight'] = this.weight;
    data['height'] = this.height;
    return data;
  }
}
