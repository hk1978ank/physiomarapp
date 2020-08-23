import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String userID;
  String email;
  String adsoyad;
  String cinsiyet;
  String yas;
  String boy;
  String kilo;
  String tur;
  String doktorID;

  //String profilURL;
  DateTime createAT;
  DateTime updateAT;
  //int seviye;
  //String userName;
  //String latessRommName;
  //String hata;
  //String hata2;


  Timestamp timeStamp;


  User({
    @required this.userID,
    @required this.email,
    this.adsoyad,
    this.cinsiyet,
    this.yas,
    this.boy,
    this.kilo,
    this.tur,
    this.doktorID,
    this.createAT,
    this.updateAT,
    //this.seviye,
    //this.userName,
    //this.latessRommName,
    //this.hata,
    //this.hata2
  });



  factory User.fromJson(Map<String, dynamic> json) => User(
    userID: json["userID"] == null ? null : json["userID"],
    email: json["email"] == null ? "e@mail.com" : json["email"],

    adsoyad: json["adsoyad"] == null ? "İsim Girilmemiş" : json["adsoyad"],
    cinsiyet: json["cinsiyet"] == null ? "Belirtilmemiş" : json["cinsiyet"],
    yas: json["yas"] == null ? 0 : json["yas"],
    boy: json["boy"] == null ? 0 : json["boy"],
    kilo:  json["kilo"] == null ? 0 : json["kilo"],
    tur:  json["tur"] == null ? "Hasta" : json["tur"],
    doktorID: json["doktorID"] == null ? "doktorID" : json["doktorID"],


    //profilURL: json["profilURL"] == null ? "https://hakankucuk.com/images/user.png"  : json["profilURL"],
    createAT: json["createAT"] == null ? DateTime.now() : (json["createAT"] as Timestamp).toDate(),
    updateAT: json["updateAT"] == null ? DateTime.now() : (json["updateAT"] as Timestamp).toDate(),
    //seviye: json["seviye"] == null ? 1 : json["seviye"],
    //userName: json["userName"] == null ? null : json["userName"],
    //latessRommName: json["latessRommName"] == null ?  "genel" : json["latessRommName"],

  );

  Map<String, dynamic> toJson() => {
    "userID": userID == null ? null : userID,
    "email": email == null ? "" : email,

    "adsoyad": adsoyad == null ? "Belirtilmemiş" : adsoyad,
    "cinsiyet": cinsiyet == null ? "Belirtilmemiş" : cinsiyet,
    "yas": yas == null ? 0 : yas,
    "boy": boy == null ? 0 : boy,
    "kilo": kilo == null ? 0 : kilo,
    "doktorID": doktorID == null ? "": doktorID,
    "tur": tur == null ? "Hasta": tur,


    //"profilURL": profilURL == null ? "https://hakankucuk.com/images/user.png" : profilURL,
    "createAT": createAT == null ? FieldValue.serverTimestamp() : createAT,
    "updateAT": updateAT == null ? FieldValue.serverTimestamp() : updateAT,
    //"seviye": seviye == null ? 1 : seviye,
    //"userName": userName == null ? email.substring(0,email.indexOf("@"))+randomSayiUret() : userName,
    //"latessRommName": latessRommName == null ? "genel" : latessRommName,

  };

  String randomSayiUret() {
    int rasageleSayi = Random().nextInt(99999);
    return rasageleSayi.toString();
  }
}
