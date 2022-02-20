import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String? title;
  String? description;
  GeoPoint? location;
  DocumentReference<Map<String, dynamic>>? owner;
  String? ownerName;
  double? price;
  double? quantity;
  String? phone_number;
  String? photo_url;
  int? views;
  String? city;

  Food(
      {this.title,
      this.description,
      this.location,
      this.owner,
      this.price,
      this.quantity,
      this.phone_number,
      this.photo_url,
      this.views,
      this.city});

  Food.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    location = json['location'];
    owner = json['owner'];
    city = json['city'];
    price = json['price'];
    quantity = json['quantity'];
    phone_number = json['phone_number'];
    photo_url = json['photo_url'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['location'] = location;
    data['owner'] = owner;
    data['price'] = price;
    data['quantity'] = quantity;
    data['phone_number'] = phone_number;
    data['photo_url'] = photo_url;
    data['views'] = views;
    data['city'] = city;
    return data;
  }
}
