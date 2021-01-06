class MemberResponseModel {
  bool success;
  List<Member> data;
  String message;

  MemberResponseModel({this.success, this.data, this.message});

  MemberResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Member>();
      json['data'].forEach((v) {
        data.add(new Member.fromJson(v));
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

class Member {
  int id;
  int kdmAccountId;
  String userId;
  String personId;
  String subjectId;
  dynamic voucherDetailId;
  String name;
  String dob;
  String gender;
  String address1;
  String address2;
  String photo;
  String verifiedConsent;
  String verifiedBarcode;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Member(
      {this.id,
        this.kdmAccountId,
        this.userId,
        this.personId,
        this.subjectId,
        this.voucherDetailId,
        this.name,
        this.dob,
        this.gender,
        this.address1,
        this.address2,
        this.photo,
        this.verifiedConsent,
        this.verifiedBarcode,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kdmAccountId = json['kdm_account_id'];
    userId = json['user_id'];
    personId = json['person_id'];
    subjectId = json['subject_id'];
    voucherDetailId = json['voucher_detail_id'];
    name = json['name'];
    dob = json['dob'];
    gender = json['gender'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    photo = json['photo'];
    verifiedConsent = json['verified_consent'].toString();
    verifiedBarcode = json['verified_barcode'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kdm_account_id'] = this.kdmAccountId;
    data['user_id'] = this.userId;
    data['person_id'] = this.personId;
    data['subject_id'] = this.subjectId;
    data['voucher_detail_id'] = this.voucherDetailId;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['photo'] = this.photo;
    data['verified_consent'] = this.verifiedConsent;
    data['verified_barcode'] = this.verifiedBarcode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
