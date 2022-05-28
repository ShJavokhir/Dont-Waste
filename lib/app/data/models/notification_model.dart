import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  String? title;
  String? description;
  String? photo_url;
  int? postedTimestamp;

  Notification(
      {this.title,
        this.description,
        this.photo_url,
        this.postedTimestamp
        });

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    photo_url = json['photo_url'];
    postedTimestamp = json['postedTimestamp'];

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['photo_url'] = photo_url;
    data['postedTimestamp'] = postedTimestamp;
    return data;
  }
}
