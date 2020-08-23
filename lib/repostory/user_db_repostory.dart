import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/modeller/anket_sorulari_model.dart';
import 'package:physiomarapp/modeller/hastaliklar.dart';
import 'package:physiomarapp/modeller/user_chat_room.dart';
import 'package:physiomarapp/modeller/user_examp.dart';
import 'package:physiomarapp/modeller/user_model.dart';
import 'package:physiomarapp/servisler/database_base.dart';
import 'package:physiomarapp/servisler/database_firestore_db_servis.dart';
import 'package:physiomarapp/view_model/locatorSafakSayar.dart';

enum CalismaModu { Relase, Demo }

class UserDbRepostory with ChangeNotifier implements DBBase {
  CalismaModu calismaModu = CalismaModu.Relase;

  FireStoreDbServis _fireStoreDbServis = locator<FireStoreDbServis>();

  @override
  Future<User> saveUserDB(User user) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.saveUserDB(user);
      return sonuc;
    }
  }

  @override
  Future<User> readUser(String userId) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.readUser(userId);
      return sonuc;
    }
  }

  @override
  Future<bool> updateUserName(String userID, String yeniUserName) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.updateUserName(userID, yeniUserName);
      return sonuc;
    }
  }

  @override
  Future<bool> updateUserprofilUrl(String userID, String yeniURL) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.updateUserprofilUrl(userID, yeniURL);
      return sonuc;
    }
  }

  @override
  Stream<QuerySnapshot> getRoomMessage(String roomName, User user) {
    print("Sohbet repodayuz..");
    if (calismaModu == CalismaModu.Demo) {
      return Stream.empty();
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = _fireStoreDbServis.getRoomMessage(roomName, user);
      return sonuc;
    }
  }

  @override
  Future<bool> sendMessage(
      String roomName, User user, UserRoomMessage userRoomMessage) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc =
          await _fireStoreDbServis.sendMessage(roomName, user, userRoomMessage);
      return sonuc;
    }
  }

  @override
  Future<bool> updateLastRoomName(String userID, String yeniRoom) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.updateLastRoomName(userID, yeniRoom);
      return sonuc;
    }
  }

  @override
  Future<UserExamp> exampGetirDB(String exampID) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.exampGetirDB(exampID);
      return sonuc;
    }
  }

  @override
  Future<UserExamp> exampGuncelleDB(UserExamp userExamp) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.exampGuncelleDB(userExamp);
      return sonuc;
    }
  }

  @override
  Future<List<UserExamp>> exampListesiGetirDB(String userID) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.exampListesiGetirDB(userID);
      return sonuc;
    }
  }

  @override
  Future<UserExamp> exampSilDB(UserExamp userExamp) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.exampSilDB(userExamp);
      return sonuc;
    }
  }

  @override
  Future<UserExamp> exampEkleDB(UserExamp userExamp) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.exampEkleDB(userExamp);
      return sonuc;
    }
  }

  @override
  Future<User> readHasta(String userId) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.readUser(userId);
      return sonuc;
    }
  }

  @override
  Future<List<HastaliklarModel>> readHastaliklar(BuildContext context) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.readHastaliklar(context);
      return sonuc;
    }
  }

  @override
  Future<bool> hastaAnketOlurtur(
      BuildContext context,
      User aktifHasta,
      User doktor,
      HastaliklarModel hastaliklar,
      List<Anketler> anketler) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.hastaAnketOlurtur(
          context, aktifHasta, doktor, hastaliklar, anketler);
      return sonuc;
    }
  }

  @override
  Future<AnketSorulariModelim> readAnketSorulari(
      BuildContext context, int anketId) {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc =  _fireStoreDbServis.readAnketSorulari(context, anketId);
      return sonuc;
    }
  }

  @override
  Future<List<AnketSorulariModelim>> readAnketSorulariWithHastsa(
      User hasta) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.readAnketSorulariWithHastsa(hasta);
      return sonuc;
    }
  }

  @override
  Future<bool> writeAnketSorulari(BuildContext context,
      AnketSorulariModelim anketSorularim, User hastaUser) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.writeAnketSorulari(
          context, anketSorularim, hastaUser);
      return sonuc;
    }
  }

  @override
  Future<List<User>> readHastaListesi(User doktor) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.readHastaListesi(doktor);
      return sonuc;
    }
  }

  @override
  Future<User> updateUserDB(User user) async {
    if (calismaModu == CalismaModu.Demo) {
      return null;
    }
    if (calismaModu == CalismaModu.Relase) {
      var sonuc = await _fireStoreDbServis.updateUserDB(user);
      return sonuc;
    }
  }
}
