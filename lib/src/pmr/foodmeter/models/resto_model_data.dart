// To parse this JSON data, do
//
//     final modelDataResto = modelDataRestoFromJson(jsonString);

import 'dart:convert';

ModelDataResto modelDataRestoFromJson(String str) => ModelDataResto.fromJson(json.decode(str));

String modelDataRestoToJson(ModelDataResto data) => json.encode(data.toJson());

class ModelDataResto {
  ModelDataResto({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  ModelDataRestoData data;
  String message;

  factory ModelDataResto.fromJson(Map<String, dynamic> json) => ModelDataResto(
    success: json["success"],
    data: ModelDataRestoData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class ModelDataRestoData {
  ModelDataRestoData({
    this.category,
    this.order,
    this.data,
  });

  String category;
  String order;
  DataData data;

  factory ModelDataRestoData.fromJson(Map<String, dynamic> json) => ModelDataRestoData(
    category: json["category"],
    order: json["order"],
    data: DataData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "order": order,
    "data": data.toJson(),
  };
}

class DataData {
  DataData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
    this.id,
    this.brandName,
    this.accountId,
    this.createdAt,
    this.categoryId,
    this.status,
    this.lastSeen,
    this.updatedAt,
    this.deletedAt,
    this.detailsCount,
  });

  int id;
  String brandName;
  String accountId;
  String createdAt;
  int categoryId;
  int status;
  String lastSeen;
  String updatedAt;
  String deletedAt;
  int detailsCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    brandName: json["brand_name"],
    accountId: json["account_id"] == null ? null : json["account_id"],
    createdAt: json["created_at"],
    categoryId: json["category_id"],
    status: json["status"],
    lastSeen: json["last_seen"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    detailsCount: json["details_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand_name": brandName,
    "account_id": accountId == null ? null : accountId,
    "created_at": createdAt,
    "category_id": categoryId,
    "status": status,
    "last_seen": lastSeen,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "details_count": detailsCount,
  };
}
