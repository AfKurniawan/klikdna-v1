class PatientCardModel {
  bool success;
  DataPatient data;
  String message;

  PatientCardModel({this.success, this.data, this.message});

  PatientCardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataPatient.fromJson(json['data']) : null;
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

class DataPatient {
  int id;
  int accountId;
  String noKtp;
  String inssuranceCode;
  String nama;
  String gender;
  String dob;
  String height;
  String weight;
  String bloodType;
  String medicalProfesional;
  String emergencyContact;
  String comorbidity;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String photo;
  List<Asuransi> detail;

  DataPatient(
      {this.id,
        this.accountId,
        this.noKtp,
        this.inssuranceCode,
        this.nama,
        this.gender,
        this.dob,
        this.height,
        this.weight,
        this.bloodType,
        this.medicalProfesional,
        this.emergencyContact,
        this.comorbidity,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.photo,
        this.detail});

  DataPatient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    noKtp = json['no_ktp'];
    inssuranceCode = json['inssurance_code'];
    nama = json['nama'];
    gender = json['gender'];
    dob = json['dob'];
    height = json['height'];
    weight = json['weight'];
    bloodType = json['blood_type'];
    medicalProfesional = json['medical_profesional'];
    emergencyContact = json['emergency_contact'];
    comorbidity = json['comorbidity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    photo = json['photo'];
    if (json['detail'] != null) {
      detail = new List<Asuransi>();
      json['detail'].forEach((v) {
        detail.add(new Asuransi.fromJson(v));
      });
    }
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
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['blood_type'] = this.bloodType;
    data['medical_profesional'] = this.medicalProfesional;
    data['emergency_contact'] = this.emergencyContact;
    data['comorbidity'] = this.comorbidity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['photo'] = this.photo;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Asuransi {
  int id;
  String type;
  String nomorAsuransi;
  String nomorPolis;
  String pemegangPolis;
  String namaPeserta;
  String nomorKartu;

  Asuransi(
      {this.id,
        this.type,
        this.nomorAsuransi,
        this.nomorPolis,
        this.pemegangPolis,
        this.namaPeserta,
        this.nomorKartu});

  Asuransi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    nomorAsuransi = json['nomor_asuransi'];
    nomorPolis = json['nomor_polis'];
    pemegangPolis = json['pemegang_polis'];
    namaPeserta = json['nama_peserta'];
    nomorKartu = json['nomor_kartu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['nomor_asuransi'] = this.nomorAsuransi;
    data['nomor_polis'] = this.nomorPolis;
    data['pemegang_polis'] = this.pemegangPolis;
    data['nama_peserta'] = this.namaPeserta;
    data['nomor_kartu'] = this.nomorKartu;
    return data;
  }
}
