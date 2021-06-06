class ListFoodModel {
  bool success;
  Data1 data;
  String message;

  ListFoodModel({this.success, this.data, this.message});

  ListFoodModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data1.fromJson(json['data']) : null;
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

class Data1 {
  String category;
  String order;
  Data1 data;

  Data1({this.category, this.order, this.data});

  Data1.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    order = json['order'];
    data = json['data'] != null ? new Data1.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['order'] = this.order;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data2 {
  int currentPage;
  List<Data2> data;
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

  Data2(
      {this.currentPage,
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
        this.total});

  Data2.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Data2>();
      json['data'].forEach((v) {
        data.add(new Data2.fromJson(v));
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
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
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

class Data3 {
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

  Data3(
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
        this.status,
        this.detailsCount});

  Data3.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brand_id'];
    //categoryId = json['category_id'];
    productName = json['product_name'];
    productUom = json['product_uom'];
    productSize = json['product_size'];
    imageLocation = json['image_location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    accountId = json['account_id'];
    status = json['status'];
    detailsCount = json['details_count'];
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
    data['details_count'] = this.detailsCount;
    return data;
  }
}
