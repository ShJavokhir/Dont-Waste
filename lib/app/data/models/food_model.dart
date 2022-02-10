class Food {
  String? title;
  String? description;
  String? location;
  double? latitude;
  double? altitude;
  int? ownerId;
  String? ownerName;
  double? price;
  double? quantity;

  Food(
      {this.title,
      this.description,
      this.location,
      this.latitude,
      this.altitude,
      this.ownerId,
      this.ownerName,
      this.price,
      this.quantity});

  Food.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    location = json['location'];
    latitude = json['latitude'];
    altitude = json['altitude'];
    ownerId = json['owner_id'];
    ownerName = json['owner_name'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['location'] = location;
    data['latitude'] = latitude;
    data['altitude'] = altitude;
    data['owner_id'] = ownerId;
    data['owner_name'] = ownerName;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}
