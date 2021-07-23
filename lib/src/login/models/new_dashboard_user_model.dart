class NewDashboardUserModel {
  String status;
  int code;
  Message message;

  NewDashboardUserModel({this.status, this.code, this.message});

  NewDashboardUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.message != null) {
      data['message'] = this.message.toJson();
    }
    return data;
  }
}

class Message {
  Account account;

  Message({this.account});

  Message.fromJson(Map<String, dynamic> json) {
    account =
    json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.account != null) {
      data['account'] = this.account.toJson();
    }
    return data;
  }
}

class Account {
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
  String referralUrl;
  String version;

  Account(
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
        this.referralUrl,
        this.version});

  Account.fromJson(Map<String, dynamic> json) {
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
    referralUrl = json['referral_url'];
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
    data['referral_url'] = this.referralUrl;
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
  bool outlet;

  Agent(
      {this.nik,
        this.npwp,
        this.religion,
        this.job,
        this.status,
        this.verified,
        this.master,
        this.outlet});

  Agent.fromJson(Map<String, dynamic> json) {
    nik = json['nik'];
    npwp = json['npwp'];
    religion = json['religion'];
    job = json['job'];
    status = json['status'];
    verified = json['verified'];
    master = json['master'];
    outlet = json['outlet'];
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
    data['outlet'] = this.outlet;
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
  String highestrank;
  String timoneposition;
  String timtwoposition;
  int timleft;
  int timright;
  int timone;
  int timtwo;
  int totalcommission;
  int monthlycycle;
  int dailycycle;
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
        this.timoneposition,
        this.timtwoposition,
        this.timleft,
        this.timright,
        this.timone,
        this.timtwo,
        this.totalcommission,
        this.monthlycycle,
        this.dailycycle,
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
    timoneposition = json['timoneposition'];
    timtwoposition = json['timtwoposition'];
    timleft = json['timleft'];
    timright = json['timright'];
    timone = json['timone'];
    timtwo = json['timtwo'];
    totalcommission = json['totalcommission'];
    monthlycycle = json['monthlycycle'];
    dailycycle = json['dailycycle'];
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
    data['timoneposition'] = this.timoneposition;
    data['timtwoposition'] = this.timtwoposition;
    data['timleft'] = this.timleft;
    data['timright'] = this.timright;
    data['timone'] = this.timone;
    data['timtwo'] = this.timtwo;
    data['totalcommission'] = this.totalcommission;
    data['monthlycycle'] = this.monthlycycle;
    data['dailycycle'] = this.dailycycle;
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
