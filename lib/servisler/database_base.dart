import 'package:flutter/material.dart';
import 'package:physiomarapp/modeller/anket_sorulari_model.dart';
import 'package:physiomarapp/modeller/hastaliklar.dart';
import 'package:physiomarapp/modeller/user_model.dart';
abstract class DBBase {

  Future<User> saveUserDB(User user);
  Future<User> updateUserDB(User user);

  Future<User> readUser(String userId);
  Future<User> readHasta(String userId);
  Future<List<HastaliklarModel>> readHastaliklar(BuildContext context);
  Future<List<User>> readHastaListesi(User doktor);
  Future<bool> hastaAnketOlurtur(BuildContext context,User aktifHasta,User doktor,HastaliklarModel hastaliklar,List<Anketler> anketler);
  Future<AnketSorulariModelim> readAnketSorulari(BuildContext context,int anketId);
  Future<bool> writeAnketSorulari(BuildContext context,AnketSorulariModelim anketSorularim,User hasta);
  Future<List<AnketSorulariModelim>> readAnketSorulariWithHastsa(User hasta);

//Future<bool> updateUserName(String userID,String yeniUserName);
// Future<bool> updateLastRoomName(String userID,String yeniRoom);
//Future<bool> updateUserprofilUrl(String userID,String yeniURL);
//Stream<QuerySnapshot> getRoomMessage(String roomName,User user);
//Future<bool> sendMessage(String roomName,User user,UserRoomMessage userRoomMessage);

//Future<UserExamp> exampGetirDB(String exampID);
//Future<UserExamp> exampEkleDB(UserExamp userExamp);
//Future<UserExamp> exampGuncelleDB(UserExamp userExamp);
//Future<UserExamp> exampSilDB(UserExamp userExamp);

//Future<List<UserExamp>> exampListesiGetirDB(String userID);


}