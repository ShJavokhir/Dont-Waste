import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? fullName;
  String? phoneNumber;
  String? photoUrl;
  int? createdTimestamp;
  int? balance;
  int? bonusCoins;
  String? fcmToken;
  double? rating;

  UserModel({
    this.fullName,
    this.phoneNumber,
    this.photoUrl,
    this.createdTimestamp,
    this.balance,
    this.bonusCoins,
    this.fcmToken,
    this.rating
  });

  UserModel.fromJson(Map<String, dynamic> json) {

    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    photoUrl = json['photoUrl'];
    balance = json['balance'];
    bonusCoins = json['bonusCoins'];
    fcmToken = json['fcmToken'];
    rating = json['rating'];
    createdTimestamp = json['createdTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['fullName'] = fullName;
    json['phoneNumber'] = phoneNumber;
    json['photoUrl'] = photoUrl;
     json['balance'] = balance;
     json['bonusCoins'] = bonusCoins;
     json['fcmToken'] = fcmToken;
     json['rating'] = rating;
     json['createdTimestamp'] = createdTimestamp;
    return json;
  }
}
