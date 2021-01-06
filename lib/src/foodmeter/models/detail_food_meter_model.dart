class DetailFoodMeterModel {
  bool success;
  Detail data;
  String message;

  DetailFoodMeterModel({this.success, this.data, this.message});

  DetailFoodMeterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Detail.fromJson(json['data']) : null;
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

class Detail {
  int id;
  int brandId;
  String productName;
  String productUom;
  String productSize;
  String imageLocation;
  String createdAt;
  String updatedAt;
  String deletedAt;
  List<Nutritions> nutritions;
  List<MobileNutritions> mobileNutritions;

  Detail(
      {this.id,
        this.brandId,
        this.productName,
        this.productUom,
        this.productSize,
        this.imageLocation,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.nutritions,
        this.mobileNutritions});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brand_id'];
    productName = json['product_name'];
    productUom = json['product_uom'];
    productSize = json['product_size'];
    imageLocation = json['image_location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['nutritions'] != null) {
      nutritions = new List<Nutritions>();
      json['nutritions'].forEach((v) {
        nutritions.add(new Nutritions.fromJson(v));
      });
    }
    if (json['mobile_nutritions'] != null) {
      mobileNutritions = new List<MobileNutritions>();
      json['mobile_nutritions'].forEach((v) {
        mobileNutritions.add(new MobileNutritions.fromJson(v));
      });
    }
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
    if (this.nutritions != null) {
      data['nutritions'] = this.nutritions.map((v) => v.toJson()).toList();
    }
    if (this.mobileNutritions != null) {
      data['mobile_nutritions'] =
          this.mobileNutritions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nutritions {
  int id;
  int productId;
  String nutritionName;
  String nutritionUom;
  String nutritionSize;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Nutritions(
      {this.id,
        this.productId,
        this.nutritionName,
        this.nutritionUom,
        this.nutritionSize,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Nutritions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    nutritionName = json['nutrition_name'];
    nutritionUom = json['nutrition_uom'];
    nutritionSize = json['nutrition_size'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['nutrition_name'] = this.nutritionName;
    data['nutrition_uom'] = this.nutritionUom;
    data['nutrition_size'] = this.nutritionSize;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
  
}

class MobileNutritions {
  int id;
  int productId;
  String nutritionName;
  String nutritionUom;
  String nutritionSize;
  String createdAt;
  String updatedAt;
  String deletedAt;

  MobileNutritions(
      {this.id,
        this.productId,
        this.nutritionName,
        this.nutritionUom,
        this.nutritionSize,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  MobileNutritions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    nutritionName = json['nutrition_name'];
    nutritionUom = json['nutrition_uom'];
    nutritionSize = json['nutrition_size'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['nutrition_name'] = this.nutritionName;
    data['nutrition_uom'] = this.nutritionUom;
    data['nutrition_size'] = this.nutritionSize;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

}


