class HomeModel {
  bool success;
  List<ArrayData> arrData;
  String message;

  HomeModel({this.success, this.arrData, this.message});

  HomeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      arrData = new List<ArrayData>();
      json['data'].forEach((v) {
        arrData.add(new ArrayData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.arrData != null) {
      data['data'] = this.arrData.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ArrayData {
  Data data;
  String imageUrl;

  ArrayData({this.data, this.imageUrl});

  ArrayData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class Data {
  int id;
  String metaTitle;
  String metaDescription;
  String title;
  String text;
  String image;
  int categoryId;
  int status;
  String createdAt;
  String updatedAt;
  String deletedAt;
  Category category;

  Data(
      {this.id,
        this.metaTitle,
        this.metaDescription,
        this.title,
        this.text,
        this.image,
        this.categoryId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    title = json['title'];
    text = json['text'];
    image = json['image'];
    categoryId = json['category_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['title'] = this.title;
    data['text'] = this.text;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class Category {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Category(
      {this.id, this.name, this.createdAt, this.updatedAt, this.deletedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
