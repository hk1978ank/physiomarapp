import 'package:cloud_firestore/cloud_firestore.dart';

class UserRoomMessage{

  final String kimden;
  final String roomName;
  final String mesaj;
  Timestamp tarih;
  bool bendenmi;
  String email;
  String userName;
  String profilURL;
  UserRoomMessage({this.kimden, this.roomName, this.mesaj, this.tarih,this.bendenmi,this.email,this.userName,this.profilURL});

  UserRoomMessage.fromMap(Map<String,dynamic> map)
      : kimden = map["kimden"],
        roomName = map["roomName"],
        mesaj = map["mesaj"],
        tarih =  map["tarih"],
        email =  map["email"],
        userName =  map["userName"],
        profilURL = map["profilURL"],
        bendenmi = map["bendenmi"];


  Map<String,dynamic> toMap()
  {
    return {
      "kimden" : kimden,
      "roomName" : roomName,
      "mesaj" :mesaj,
      "tarih" : tarih,
      "email" : email,
      "userName" : userName,
      "bendenmi" : bendenmi,
      "profilURL" : profilURL,
    };
  }

  @override
  String toString() {
    return 'UserRoomMessage NesNesi{kimden: $kimden, odaIsmi: $roomName, mesaj: $mesaj, tarih: $tarih , bendenmi: $bendenmi , email : $email , userName : $userName}';
  }
}