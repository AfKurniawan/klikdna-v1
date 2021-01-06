class AsuransiModel {
  bool success;
  AsuransiData data;
  String message;

  AsuransiModel({this.success, this.data, this.message});

  AsuransiModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new AsuransiData.fromJson(json['data']) : null;
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

class AsuransiData {
  int id;
  int patientCardId;
  String nomorAsuransi;
  String nomorPolis;
  String pemegangPolis;
  String namaPeserta;
  String nomorKartu;
  String createdAt;
  String updatedAt;
  String deletedAt;

  AsuransiData(
      {this.id,
        this.patientCardId,
        this.nomorAsuransi,
        this.nomorPolis,
        this.pemegangPolis,
        this.namaPeserta,
        this.nomorKartu,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  AsuransiData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientCardId = json['patient_card_id'];
    nomorAsuransi = json['nomor_asuransi'];
    nomorPolis = json['nomor_polis'];
    pemegangPolis = json['pemegang_polis'];
    namaPeserta = json['nama_peserta'];
    nomorKartu = json['nomor_kartu'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_card_id'] = this.patientCardId;
    data['nomor_asuransi'] = this.nomorAsuransi;
    data['nomor_polis'] = this.nomorPolis;
    data['pemegang_polis'] = this.pemegangPolis;
    data['nama_peserta'] = this.namaPeserta;
    data['nomor_kartu'] = this.nomorKartu;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
