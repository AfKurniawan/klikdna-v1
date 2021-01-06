class FoodMeterModel {
  bool success;
  List<Food> data;
  String message;

  FoodMeterModel({this.success, this.data, this.message});

  FoodMeterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Food>();
      json['data'].forEach((v) {
        data.add(new Food.fromJson(v));
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

class Food {
  int id;
  int brandId;
  String productName;
  String productUom;
  String productSize;
  String imageLocation;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Food(
      {this.id,
        this.brandId,
        this.productName,
        this.productUom,
        this.productSize,
        this.imageLocation,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brand_id'];
    productName = json['product_name'];
    productUom = json['product_uom'];
    productSize = json['product_size'];
    imageLocation = json['image_location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_id'] = this.brandId;
    data['product_name'] = this.productName;
    data['product_uom'] = this.productUom;
    data['product_size'] = this.productSize;
    data['image_location'] = this.imageLocation;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}