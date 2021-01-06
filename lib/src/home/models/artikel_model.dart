class ArtikelModel {
  bool success;
  List<Artikel> data;
  String message;

  ArtikelModel({this.success, this.data, this.message});

  ArtikelModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Artikel>();
      json['data'].forEach((v) {
        data.add(new Artikel.fromJson(v));
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

class Artikel {
  int id;
  String title;
  String author;
  String description;
  String bodyText;
  String image;
  String createdAt;
  String imageLink;

  Artikel(
      {this.id,
        this.title,
        this.author,
        this.description,
        this.bodyText,
        this.image,
        this.createdAt,
        this.imageLink});

  Artikel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    description = json['description'];
    bodyText = json['body_text'];
    image = json['image'];
    createdAt = json['created_at'];
    imageLink = json['image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['description'] = this.description;
    data['body_text'] = this.bodyText;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['image_link'] = this.imageLink;
    return data;
  }
}