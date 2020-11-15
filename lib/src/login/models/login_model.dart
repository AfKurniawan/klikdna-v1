class LoginModel {
  User user;

  LoginModel({this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String username;
  String email;
  String role;
  String lastlogin;
  bool active;
  String created;
  Agent agent;
  Member member;
  Sponsor sponsor;
  String accesskey;
  Webviews webviews;
  JsonData jsondata;
  String referralUrl;
  int code;
  String message;
  String version;

  User(
      {this.id,
        this.username,
        this.email,
        this.role,
        this.lastlogin,
        this.active,
        this.created,
        this.agent,
        this.member,
        this.sponsor,
        this.accesskey,
        this.webviews,
        this.jsondata,
        this.referralUrl,
        this.code,
        this.message,
        this.version});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    role = json['role'];
    lastlogin = json['lastlogin'];
    active = json['active'];
    created = json['created'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    member =
    json['member'] != null ? new Member.fromJson(json['member']) : null;
    sponsor =
    json['sponsor'] != null ? new Sponsor.fromJson(json['sponsor']) : null;
    accesskey = json['accesskey'];
    webviews = json['webviews'] != null
        ? new Webviews.fromJson(json['webviews'])
        : null;
    jsondata = json['json'] != null ? new JsonData.fromJson(json['json']) : null;
    referralUrl = json['referral_url'];
    code = json['code'];
    message = json['message'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['role'] = this.role;
    data['lastlogin'] = this.lastlogin;
    data['active'] = this.active;
    data['created'] = this.created;
    if (this.agent != null) {
      data['agent'] = this.agent.toJson();
    }
    if (this.member != null) {
      data['member'] = this.member.toJson();
    }
    if (this.sponsor != null) {
      data['sponsor'] = this.sponsor.toJson();
    }
    data['accesskey'] = this.accesskey;
    if (this.webviews != null) {
      data['webviews'] = this.webviews.toJson();
    }
    if (this.jsondata != null) {
      data['json'] = this.jsondata.toJson();
    }
    data['referral_url'] = this.referralUrl;
    data['code'] = this.code;
    data['message'] = this.message;
    data['version'] = this.version;
    return data;
  }
}

class Agent {
  String nik;
  String npwp;
  String religion;
  String job;
  String status;
  bool verified;
  bool master;
  bool stockist;

  Agent(
      {this.nik,
        this.npwp,
        this.religion,
        this.job,
        this.status,
        this.verified,
        this.master,
        this.stockist});

  Agent.fromJson(Map<String, dynamic> json) {
    nik = json['nik'];
    npwp = json['npwp'];
    religion = json['religion'];
    job = json['job'];
    status = json['status'];
    verified = json['verified'];
    master = json['master'];
    stockist = json['stockist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nik'] = this.nik;
    data['npwp'] = this.npwp;
    data['religion'] = this.religion;
    data['job'] = this.job;
    data['status'] = this.status;
    data['verified'] = this.verified;
    data['master'] = this.master;
    data['stockist'] = this.stockist;
    return data;
  }
}

class Member {
  String number;
  String firstname;
  String lastname;
  String birthdate;
  String gender;
  String address;
  String kelurahan;
  String subdistrict;
  String city;
  String province;
  String zipcode;
  String phone;
  int leftcv;
  int rightcv;
  int leftpointreward;
  int rightpointreward;
  int commission;
  String rank;
  String par;
  String expired;
  var highestrank;
  int timone;
  int timtwo;
  int totalcommission;
  String type;

  Member(
      {this.number,
        this.firstname,
        this.lastname,
        this.birthdate,
        this.gender,
        this.address,
        this.kelurahan,
        this.subdistrict,
        this.city,
        this.province,
        this.zipcode,
        this.phone,
        this.leftcv,
        this.rightcv,
        this.leftpointreward,
        this.rightpointreward,
        this.commission,
        this.rank,
        this.par,
        this.expired,
        this.highestrank,
        this.timone,
        this.timtwo,
        this.totalcommission,
        this.type});

  Member.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    address = json['address'];
    kelurahan = json['kelurahan'];
    subdistrict = json['subdistrict'];
    city = json['city'];
    province = json['province'];
    zipcode = json['zipcode'];
    phone = json['phone'];
    leftcv = json['leftcv'];
    rightcv = json['rightcv'];
    leftpointreward = json['leftpointreward'];
    rightpointreward = json['rightpointreward'];
    commission = json['commission'];
    rank = json['rank'];
    par = json['par'];
    expired = json['expired'];
    highestrank = json['highestrank'];
    timone = json['timone'];
    timtwo = json['timtwo'];
    totalcommission = json['totalcommission'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['birthdate'] = this.birthdate;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['kelurahan'] = this.kelurahan;
    data['subdistrict'] = this.subdistrict;
    data['city'] = this.city;
    data['province'] = this.province;
    data['zipcode'] = this.zipcode;
    data['phone'] = this.phone;
    data['leftcv'] = this.leftcv;
    data['rightcv'] = this.rightcv;
    data['leftpointreward'] = this.leftpointreward;
    data['rightpointreward'] = this.rightpointreward;
    data['commission'] = this.commission;
    data['rank'] = this.rank;
    data['par'] = this.par;
    data['expired'] = this.expired;
    data['highestrank'] = this.highestrank;
    data['timone'] = this.timone;
    data['timtwo'] = this.timtwo;
    data['totalcommission'] = this.totalcommission;
    data['type'] = this.type;
    return data;
  }

}

class Sponsor {
  String firstname;
  String lastname;
  String gender;
  String address;
  String kelurahan;
  String subdistrict;
  String city;
  String province;
  String phone;

  Sponsor(
      {this.firstname,
        this.lastname,
        this.gender,
        this.address,
        this.kelurahan,
        this.subdistrict,
        this.city,
        this.province,
        this.phone});

  Sponsor.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    gender = json['gender'];
    address = json['address'];
    kelurahan = json['kelurahan'];
    subdistrict = json['subdistrict'];
    city = json['city'];
    province = json['province'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['kelurahan'] = this.kelurahan;
    data['subdistrict'] = this.subdistrict;
    data['city'] = this.city;
    data['province'] = this.province;
    data['phone'] = this.phone;
    return data;
  }
}

class Webviews {
  String dashboard;
  String tree;
  String generasi;
  String referral;
  String cv;
  String pointreward;
  String kebijakanPrivacy;
  String ketentuanPengguna;

  Webviews(
      {this.dashboard,
        this.tree,
        this.generasi,
        this.referral,
        this.cv,
        this.pointreward,
        this.kebijakanPrivacy,
        this.ketentuanPengguna});

  Webviews.fromJson(Map<String, dynamic> json) {
    dashboard = json['dashboard'];
    tree = json['tree'];
    generasi = json['generasi'];
    referral = json['referral'];
    cv = json['cv'];
    pointreward = json['pointreward'];
    kebijakanPrivacy = json['kebijakan_privacy'];
    ketentuanPengguna = json['ketentuan_pengguna'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dashboard'] = this.dashboard;
    data['tree'] = this.tree;
    data['generasi'] = this.generasi;
    data['referral'] = this.referral;
    data['cv'] = this.cv;
    data['pointreward'] = this.pointreward;
    data['kebijakan_privacy'] = this.kebijakanPrivacy;
    data['ketentuan_pengguna'] = this.ketentuanPengguna;
    return data;
  }
}

class JsonData {
  Wallets wallets;
  Wallets referrals;

  JsonData({this.wallets, this.referrals});

  JsonData.fromJson(Map<String, dynamic> json) {
    wallets =
    json['wallets'] != null ? new Wallets.fromJson(json['wallets']) : null;
    referrals = json['referrals'] != null
        ? new Wallets.fromJson(json['referrals'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wallets != null) {
      data['wallets'] = this.wallets.toJson();
    }
    if (this.referrals != null) {
      data['referrals'] = this.referrals.toJson();
    }
    return data;
  }
}

class Wallets {
  String method;
  String url;
  Params params;

  Wallets({this.method, this.url, this.params});

  Wallets.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    url = json['url'];
    params =
    json['params'] != null ? new Params.fromJson(json['params']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    data['url'] = this.url;
    if (this.params != null) {
      data['params'] = this.params.toJson();
    }
    return data;
  }
}

class Params {
  String accesskey;
  String typeId;
  String datefrom;
  String dateto;

  Params({this.accesskey, this.typeId, this.datefrom, this.dateto});

  Params.fromJson(Map<String, dynamic> json) {
    accesskey = json['accesskey'];
    typeId = json['type_id'];
    datefrom = json['datefrom'];
    dateto = json['dateto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accesskey'] = this.accesskey;
    data['type_id'] = this.typeId;
    data['datefrom'] = this.datefrom;
    data['dateto'] = this.dateto;
    return data;
  }
}

class ParamsKey {
  String accesskey;

  ParamsKey({this.accesskey});

  ParamsKey.fromJson(Map<String, dynamic> json) {
    accesskey = json['accesskey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accesskey'] = this.accesskey;
    return data;
  }
}
