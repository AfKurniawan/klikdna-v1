class DetailReportModel {
  bool success;
  ReportData data;
  String message;

  DetailReportModel({this.success, this.data, this.message});

  DetailReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ReportData.fromJson(json['data']) : null;
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

class ReportData {
  String userId;
  String serviceName;
  String personId;
  String reportId;
  String statusReport;
  String linkPdf;
  List<ReportDetail> reportDetail;

  ReportData(
      {this.userId,
        this.serviceName,
        this.personId,
        this.reportId,
        this.statusReport,
        this.linkPdf,
        this.reportDetail});

  ReportData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    serviceName = json['service_name'];
    personId = json['person_id'];
    reportId = json['report_id'];
    statusReport = json['status_report'];
    linkPdf = json['link_pdf'];
    if (json['report_detail'] != null) {
      reportDetail = new List<ReportDetail>();
      json['report_detail'].forEach((v) {
        reportDetail.add(new ReportDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['service_name'] = this.serviceName;
    data['person_id'] = this.personId;
    data['report_id'] = this.reportId;
    data['status_report'] = this.statusReport;
    data['link_pdf'] = this.linkPdf;
    if (this.reportDetail != null) {
      data['report_detail'] = this.reportDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportDetail {
  String noModul;
  String namaModul;
  String deskripsi;
  String hasilKamu;
  String deskripsiHasil;
  String catatanHasil;
  String gambarJudul;
  String gambarHasil;
  List<Rekomendasi> rekomendasi;
  List<PenjelasanIlmiah> penjelasanIlmiah;

  ReportDetail(
      {this.noModul,
        this.namaModul,
        this.deskripsi,
        this.hasilKamu,
        this.deskripsiHasil,
        this.catatanHasil,
        this.gambarJudul,
        this.gambarHasil,
        this.rekomendasi,
        this.penjelasanIlmiah});

  ReportDetail.fromJson(Map<String, dynamic> json) {
    noModul = json['no_modul'];
    namaModul = json['nama_modul'];
    deskripsi = json['deskripsi'];
    hasilKamu = json['hasil_kamu'];
    deskripsiHasil = json['deskripsi_hasil'];
    catatanHasil = json['catatan_hasil'];
    gambarJudul = json['gambar_judul'];
    gambarHasil = json['gambar_hasil'];
    if (json['rekomendasi'] != null) {
      rekomendasi = new List<Rekomendasi>();
      json['rekomendasi'].forEach((v) {
        rekomendasi.add(new Rekomendasi.fromJson(v));
      });
    }
    if (json['penjelasan_ilmiah'] != null) {
      penjelasanIlmiah = new List<PenjelasanIlmiah>();
      json['penjelasan_ilmiah'].forEach((v) {
        penjelasanIlmiah.add(new PenjelasanIlmiah.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_modul'] = this.noModul;
    data['nama_modul'] = this.namaModul;
    data['deskripsi'] = this.deskripsi;
    data['hasil_kamu'] = this.hasilKamu;
    data['deskripsi_hasil'] = this.deskripsiHasil;
    data['catatan_hasil'] = this.catatanHasil;
    data['gambar_judul'] = this.gambarJudul;
    data['gambar_hasil'] = this.gambarHasil;
    if (this.rekomendasi != null) {
      data['rekomendasi'] = this.rekomendasi.map((v) => v.toJson()).toList();
    }
    if (this.penjelasanIlmiah != null) {
      data['penjelasan_ilmiah'] =
          this.penjelasanIlmiah.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rekomendasi {
  int noUrut;
  String ikonRekomendasi;
  String judulRekomendasi;
  String gambarRekomendasi;

  Rekomendasi(
      {this.noUrut,
        this.ikonRekomendasi,
        this.judulRekomendasi,
        this.gambarRekomendasi});

  Rekomendasi.fromJson(Map<String, dynamic> json) {
    noUrut = json['no_urut'];
    ikonRekomendasi = json['ikon_rekomendasi'];
    judulRekomendasi = json['judul_rekomendasi'];
    gambarRekomendasi = json['gambar_rekomendasi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_urut'] = this.noUrut;
    data['ikon_rekomendasi'] = this.ikonRekomendasi;
    data['judul_rekomendasi'] = this.judulRekomendasi;
    data['gambar_rekomendasi'] = this.gambarRekomendasi;
    return data;
  }
}

class PenjelasanIlmiah {
  int noUrut;
  String judulPenjelasan;
  String keterangan;
  PenjelasanDetail penjelasanDetail;
  String gambarPenjelasan;
  String keteranganGambar;

  PenjelasanIlmiah(
      {this.noUrut,
        this.judulPenjelasan,
        this.keterangan,
        this.penjelasanDetail,
        this.gambarPenjelasan,
        this.keteranganGambar});

  PenjelasanIlmiah.fromJson(Map<String, dynamic> json) {
    noUrut = json['no_urut'];
    judulPenjelasan = json['judul_penjelasan'];
    keterangan = json['keterangan'];
    penjelasanDetail = json['penjelasan_detail'] != null
        ? new PenjelasanDetail.fromJson(json['penjelasan_detail'])
        : null;
    gambarPenjelasan = json['gambar_penjelasan'];
    keteranganGambar = json['keterangan_gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_urut'] = this.noUrut;
    data['judul_penjelasan'] = this.judulPenjelasan;
    data['keterangan'] = this.keterangan;
    if (this.penjelasanDetail != null) {
      data['penjelasan_detail'] = this.penjelasanDetail.toJson();
    }
    data['gambar_penjelasan'] = this.gambarPenjelasan;
    data['keterangan_gambar'] = this.keteranganGambar;
    return data;
  }
}

class PenjelasanDetail {
  String tipeInisial;
  String tipeDetail;
  List<DataDetail> dataDetail;

  PenjelasanDetail({this.tipeInisial, this.tipeDetail, this.dataDetail});

  PenjelasanDetail.fromJson(Map<String, dynamic> json) {
    tipeInisial = json['tipe_inisial'];
    tipeDetail = json['tipe_detail'];
    if (json['data_detail'] != null) {
      dataDetail = new List<DataDetail>();
      json['data_detail'].forEach((v) {
        dataDetail.add(new DataDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tipe_inisial'] = this.tipeInisial;
    data['tipe_detail'] = this.tipeDetail;
    if (this.dataDetail != null) {
      data['data_detail'] = this.dataDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataDetail {
  int noUrut;
  String judul;
  String keterangan;

  DataDetail({this.noUrut, this.judul, this.keterangan});

  DataDetail.fromJson(Map<String, dynamic> json) {
    noUrut = json['no_urut'];
    judul = json['judul'];
    keterangan = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_urut'] = this.noUrut;
    data['judul'] = this.judul;
    data['keterangan'] = this.keterangan;
    return data;
  }
}
