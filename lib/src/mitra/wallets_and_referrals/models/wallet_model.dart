class WalletModel {

  List<Wallet> data;

  WalletModel({this.data});

  WalletModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Wallet>();
      json['data'].forEach((v) {
        data.add(new Wallet.fromJson(v));
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

class Wallet {
  String created;
  int typeId;
  String type;
  String from;
  int nominal;
  int saldo;
  String status;

  Wallet(
      {this.created,
        this.typeId,
        this.type,
        this.from,
        this.nominal,
        this.saldo,
        this.status});

  Wallet.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    typeId = json['type_id'];
    type = json['type'];
    from = json['from'];
    nominal = json['nominal'];
    saldo = json['saldo'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created'] = this.created;
    data['type_id'] = this.typeId;
    data['type'] = this.type;
    data['from'] = this.from;
    data['nominal'] = this.nominal;
    data['saldo'] = this.saldo;
    data['status'] = this.status;
    return data;
  }
}
