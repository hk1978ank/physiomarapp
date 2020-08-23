
import 'package:cloud_firestore/cloud_firestore.dart';

class UserExamp {
  String exampID;
  String userID;
  String exampbaslik;
  String examTarih;
  String exampRoom;
  int exampSira;
  String kalanZaman;
  bool primary;

  UserExamp({this.exampID,this.userID, this.exampbaslik, this.examTarih, this.exampRoom,
    this.exampSira,this.primary});

  factory UserExamp.fromJson(Map<String, dynamic> json) => UserExamp(
    exampID: json["exampID"] == null ? null : json["exampID"],
    userID: json["userID"] == null ? null : json["userID"],
    exampbaslik: json["exampbaslik"] == null ? null : json["exampbaslik"],
    examTarih: json["examTarih"] == null ? FieldValue.serverTimestamp() : json["examTarih"],
    exampRoom: json["exampRoom"] == null ? "genel" : json["exampRoom"],
    exampSira: json["exampSira"] == null ? 1 : json["exampSira"],
    primary: json["primary"] == null ? true : json["primary"],
  );

  Map<String, dynamic> toJson() => {
    "exampID": exampID == null ? null : exampID,
    "userID": userID == null ? null : userID,
    "exampbaslik": exampbaslik == null ? "" : exampbaslik,
    "examTarih": examTarih == null ? FieldValue.serverTimestamp() : examTarih,
    "exampRoom": exampRoom == null ? "genel" : exampRoom,
    "exampSira": exampSira == null ? 1 : exampSira,
    "primary" : primary== null ? null : primary,
  };

  @override
  String toString() {
    return 'UserExamp{exampID: $exampID, userID: $userID, exampbaslik: $exampbaslik, examTarih: $examTarih, exampRoom: $exampRoom, exampSira: $exampSira}';
  }
}