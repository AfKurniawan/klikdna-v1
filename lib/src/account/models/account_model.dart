class AccountModel {
  bool success;
  Data data;
  String message;

  AccountModel({this.success, this.data, this.message});

  AccountModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int kdmAccountId;
  String userId;
  int verifykdmAccessReport;
  String name;
  String username;
  String phone;
  String dob;
  String gender;
  List<PatientCard> patientCard;

  Data(
      {this.kdmAccountId,
        this.userId,
        this.verifykdmAccessReport,
        this.name,
        this.username,
        this.phone,
        this.dob,
        this.gender,
        this.patientCard});

  Data.fromJson(Map<String, dynamic> json) {
    kdmAccountId = json['kdm_account_id'];
    userId = json['user_id'];
    verifykdmAccessReport = json['verifykdm_access_report'];
    name = json['name'];
    username = json['username'];
    phone = json['phone'];
    dob = json['dob'];
    gender = json['gender'];
    if (json['patient_card'] != null) {
      patientCard = new List<PatientCard>();
      json['patient_card'].forEach((v) {
        patientCard.add(new PatientCard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kdm_account_id'] = this.kdmAccountId;
    data['user_id'] = this.userId;
    data['verifykdm_access_report'] = this.verifykdmAccessReport;
    data['name'] = this.name;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    if (this.patientCard != null) {
      data['patient_card'] = this.patientCard.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientCard {
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

  PatientCard(
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
        this.photo});

  PatientCard.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
