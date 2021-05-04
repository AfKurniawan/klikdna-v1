class FoodMeterLastSeenModel {
  bool success;
  Data data;
  String message;

  FoodMeterLastSeenModel({this.success, this.data, this.message});

  FoodMeterLastSeenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int currentPage;
  List<DataArray> dataArray;
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

  Data(
      {this.currentPage,
        this.dataArray,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['dataArray'] != null) {
      dataArray = new List<DataArray>();
      json['dataArray'].forEach((v) {
        dataArray.add(new DataArray.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.dataArray != null) {
      data['dataArray'] = this.dataArray.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class DataArray {
  int id;
  int mobileBrandId;
  int mobileProductId;
  int accountId;
  String createdAt;
  String updatedAt;
  Brand brand;
  Product product;

  DataArray(
      {this.id,
        this.mobileBrandId,
        this.mobileProductId,
        this.accountId,
        this.createdAt,
        this.updatedAt,
        this.brand,
        this.product});

  DataArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobileBrandId = json['mobile_brand_id'];
    mobileProductId = json['mobile_product_id'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile_brand_id'] = this.mobileBrandId;
    data['mobile_product_id'] = this.mobileProductId;
    data['account_id'] = this.accountId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Brand {
  int id;
  String brandName;
  String accountId;
  String createdAt;
  int categoryId;
  int status;
  String lastSeen;
  String updatedAt;
  String deletedAt;

  Brand(
      {this.id,
        this.brandName,
        this.accountId,
        this.createdAt,
        this.categoryId,
        this.status,
        this.lastSeen,
        this.updatedAt,
        this.deletedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    categoryId = json['category_id'];
    status = json['status'];
    lastSeen = json['last_seen'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
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
    return data;
  }
}

class Product {
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

  Product(
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

  Product.fromJson(Map<String, dynamic> json) {
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
