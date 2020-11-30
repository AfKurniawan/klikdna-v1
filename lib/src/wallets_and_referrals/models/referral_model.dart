class ReferralModel {
  List<Referral> data;

  ReferralModel({this.data});

  ReferralModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Referral>();
      json['data'].forEach((v) {
        data.add(new Referral.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Referral {
  String created;
  String name;
  String position;
  String rank;
  String par;
  String type;
  String status;

  Referral(
      {this.created,
        this.name,
        this.position,
        this.rank,
        this.par,
        this.type,
        this.status});

  Referral.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    name = json['name'];
    position = json['position'];
    rank = json['rank'];
    par = json['par'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created'] = this.created;
    data['name'] = this.name;
    data['position'] = this.position;
    data['rank'] = this.rank;
    data['par'] = this.par;
    data['type'] = this.type;
    data['status'] = this.status;
    return data;
  }
}
