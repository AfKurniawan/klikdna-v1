class FoodBrandsModel {
  bool success;
  DataBrand data;
  String message;

  FoodBrandsModel({this.success, this.data, this.message});

  FoodBrandsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataBrand.fromJson(json['data']) : null;
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

class DataBrand {
  int id;
  String brandName;
  Null accountId;
  String createdAt;
  int categoryId;
  int status;
  String lastSeen;
  String updatedAt;
  Null deletedAt;
  List<BrandDetail> detail;

  DataBrand(
      {this.id,
        this.brandName,
        this.accountId,
        this.createdAt,
        this.categoryId,
        this.status,
        this.lastSeen,
        this.updatedAt,
        this.deletedAt,
        this.detail});

  DataBrand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    categoryId = json['category_id'];
    status = json['status'];
    lastSeen = json['last_seen'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['detail'] != null) {
      detail = new List<BrandDetail>();
      json['detail'].forEach((v) {
        detail.add(new BrandDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_name'] = this.brandName;
    data['account_id'] = this.accountId;
    data['created_at'] = this.createdAt;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['last_seen'] = this.lastSeen;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandDetail {
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

  BrandDetail(
      {this.id,
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
        this.status});

  BrandDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brand_id'];
    categoryId = json['category_id'];
    productName = json['product_name'];
    productUom = json['product_uom'];
    productSize = json['product_size'];
    imageLocation = json['image_location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    accountId = json['account_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_id'] = this.brandId;
    data['category_id'] = this.categoryId;
    data['product_name'] = this.productName;
    data['product_uom'] = this.productUom;
    data['product_size'] = this.productSize;
    data['image_location'] = this.imageLocation;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['account_id'] = this.accountId;
    data['status'] = this.status;
    return data;
  }
}
