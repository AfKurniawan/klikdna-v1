class ModelData {
  ModelData({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  ModelDataData data;
  String message;

  factory ModelData.fromJson(Map<String, dynamic> json) => ModelData(
    success: json["success"],
    data: ModelDataData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class ModelDataData {
  ModelDataData({
    this.category,
    this.order,
    this.data,
  });

  String category;
  String order;
  DataData data;

  factory ModelDataData.fromJson(Map<String, dynamic> json) => ModelDataData(
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
    this.brandId,
    this.categoryId,
    this.productName,
    this.productUom,
    this.productSize,
    this.imageLocation,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.accountId,
    this.status,
    this.detailsCount,
  });

  int id;
  int brandId;
  String categoryId;
  String productName;
  String productUom;
  String productSize;
  String imageLocation;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String accountId;
  int status;
  int detailsCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    brandId: json["brand_id"],
    categoryId: json["category_id"],
    productName: json["product_name"],
    productUom: json["product_uom"],
    productSize: json["product_size"],
    imageLocation: json["image_location"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    accountId: json["account_id"],
    status: json["status"],
    detailsCount: json["details_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand_id": brandId,
    "category_id": categoryId,
    "product_name": productName,
    "product_uom": productUom,
    "product_size": productSize,
    "image_location": imageLocation,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "account_id": accountId,
    "status": status,
    "details_count": detailsCount,
  };
}
