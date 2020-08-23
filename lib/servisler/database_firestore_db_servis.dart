import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:physiomarapp/modeller/anket_sorulari_model.dart';
import 'package:physiomarapp/modeller/hastaliklar.dart';
import 'package:physiomarapp/modeller/user_chat_room.dart';
import 'package:physiomarapp/modeller/user_examp.dart';
import 'package:physiomarapp/modeller/user_model.dart';
import 'package:physiomarapp/servisler/database_base.dart';

class FireStoreDbServis implements DBBase {
  Firestore _firestore = Firestore.instance;

  @override
  Future<User> saveUserDB(User user) async {
    print("FireStore Save User Çalıştı :" + user.toJson().toString());

    Map _eklenecekUserMAP = user.toJson();
    _eklenecekUserMAP["createAT"] = FieldValue.serverTimestamp();
    _eklenecekUserMAP["updateAT"] = FieldValue.serverTimestamp();
    print("Eklenecek User234 :" + _eklenecekUserMAP.toString());
    await _firestore
        .collection("users")
        .document(user.userID)
        .setData(_eklenecekUserMAP);

    DocumentSnapshot _okunanUser =
        await Firestore.instance.document("users/${user.userID}").get();

    Map okunanBilgileri = _okunanUser.data;
    User _okunanUserBilgileriNesnesi = User.fromJson(okunanBilgileri);

    //print("saveUser db_servis_firestore Okunan User : " +
//        _okunanUserBilgileriNesnesi.toJson().toString());
    print("firesotoredB saveUserDB return oldu Başarılı");
    return _okunanUserBilgileriNesnesi;
  }

  @override
  Future<User> readUser(String userId) async {
    print("okunacak user :"+userId.toString());
    //if(userId==nu)
    DocumentSnapshot _okunanUser =
        await Firestore.instance.document("users/${userId}").get();
    if (_okunanUser.data == null) {
      print("firesotoredB readUser Boş Döndü return oldu");
      return null;
    }
    Map okunanBilgileri = _okunanUser.data;
    User _okunanUserBilgileriNesnesi = User.fromJson(okunanBilgileri);
    //print("FS DB den kullanıcımız okundu : (JSON) : " +
    //   _okunanUserBilgileriNesnesi.toJson().toString());
    print("firesotoredB readUser return oldu Başarılı");
    return _okunanUserBilgileriNesnesi;
  }

  @override
  Future<bool> updateUserName(String userID, String yeniUserName) async {
    var sorgu = await _firestore
        .collection("users")
        .where("userName", isEqualTo: yeniUserName)
        .getDocuments();
    if (sorgu.documents.length >= 1) {
      print("database_firestore updateUserName HATALI return oldu");
      return false;
    } else {
      await _firestore
          .collection("users")
          .document(userID)
          .updateData({"userName": yeniUserName}).then((value) {
        //  print("database_firestore updateUserName Başarılı return oldu");
        //  return true;
      });
    }
    print("database_firestore updateUserName Başarılı return oldu");
    return true;
  }

  @override
  Future<bool> updateUserprofilUrl(String userID, String yeniURL) async {
    await _firestore
        .collection("users")
        .document(userID)
        .updateData({"profilURL": yeniURL}).then((value) {
      //   return true;
    });
    print("database_firestore updateUserprofilUrl başarılı return oldu");
    return true;
  }

  @override
  Stream<QuerySnapshot> getRoomMessage(String roomName, User user) {
    print(
        "database_firestore getRoomMessage Yeni Bir streamGeldi=======1=====");
    /*
    var mesajID = _firestore.collection("room").document(roomName).collection("mesajlar").getDocuments();

    var snapShot = _firestore
        .collection("room")
        .document(roomName)
        .collection("mesajlar")
        //.document(mesajID)
        .snapshots();
    */
    var snp = _firestore
        .collection("room")
        .document(roomName)
        .collection("mesajlar")
        .orderBy("tarih", descending: true)
        .snapshots();

    //Stream<List<UserRoomMessage>> sonuc = snapShot.map((mesajListesi) => mesajListesi.documents.map((mesaj) => UserRoomMessage.fromMap(mesaj.data)));

    //sonuc.forEach((element) {
    //  print("Deneme");
    //});
    // print("database_firestore getRoomMessage Yeni Bir streamGeldi======2======");
    return snp;
  }

  @override
  Future<bool> sendMessage(
      String roomName, User user, UserRoomMessage userRoomMessage) async {
    // print("Oda ismi : $roomName");
    Map _eklenecekMesajMAP = userRoomMessage.toMap();
    _eklenecekMesajMAP["tarih"] = DateTime.now();
    _eklenecekMesajMAP["roomName"] = roomName;
    _eklenecekMesajMAP["email"] = user.email;
    //_eklenecekMesajMAP ["profilURL"] = user.profilURL;
    //_eklenecekMesajMAP ["userName"] = user.userName;
    _eklenecekMesajMAP["timeStamp"] = FieldValue.serverTimestamp();

    // print("firestore sendMessage  asıl sorgudayız 1 : "+ _eklenecekMesajMAP.toString());
    var mesajID = _firestore.collection("room").document().documentID;
    var sonuc = await _firestore
        .collection("room")
        .document(roomName)
        .collection("mesajlar")
        .document(mesajID)
        .setData(_eklenecekMesajMAP)
        .then((value) {
      //return true;
    });
    print("database_firestore sendMessage return oldu BAŞARILI ");
    return true;
    //return Future.value(false);
  }

  @override
  Future<bool> updateLastRoomName(String userID, String yeniRoom) async {
    await _firestore
        .collection("users")
        .document(userID)
        .updateData({"latessRommName": yeniRoom}).then((value) {
      //  return true;
    });
    print("database_firestore updateLastRoomName return oldu BAŞARILI ");
    return true;
  }

  @override
  Future<UserExamp> exampGetirDB(String exampID) {
    print("database_firestore exampGetirDB return kod yazılmadı");
  }

  @override
  Future<UserExamp> exampGuncelleDB(UserExamp userExamp) async {
    print("Exam Gücelle DB içerisindeyiz...: Gelen examp : " +
        userExamp.toString());
    var sonuc = await _firestore
        .collection("users")
        .document(userExamp.userID)
        .collection("sinavlarim")
        .document(userExamp.exampID)
        .updateData(userExamp.toJson())
        .then((value) {
      // return userExamp;
    });
    print("database_firestore exampGuncelleDB return başarılı");
    return userExamp;
  }

  @override
  Future<List<UserExamp>> exampListesiGetirDB(String userID) async {
    QuerySnapshot sinavListesi = await _firestore
        .collection("users")
        .document(userID)
        .collection("sinavlarim")
        .getDocuments();
    var sinavListesiDocuman = sinavListesi.documents;
    List<UserExamp> _userExampList = [];
    sinavListesiDocuman.forEach((sinavSnapShot) {
      Map _sinavSnapShot = sinavSnapShot.data;
      //print("Gelen veri Datası MAp :"+ _sinavSnapShot.toString());
      UserExamp sinav = UserExamp.fromJson(_sinavSnapShot);
      //print("Listeye Eklenecek Olan Sınavımız : "+sinav.toString());
      _userExampList.add(sinav);
    });

    print("database_firestore exampListesiGetirDB return oldu ");
    return _userExampList;
  }

  @override
  Future<UserExamp> exampSilDB(UserExamp userExamp) async {
    var sonuc = await _firestore
        .collection("users")
        .document(userExamp.userID)
        .collection("sinavlarim")
        .document(userExamp.exampID)
        .delete()
        .then((value) {
      //      return null;
    });
    print("database_firestore exampListesiGetirDB return oldu SİLİNEMEDİ");
    return null;
  }

  @override
  Future<UserExamp> exampEkleDB(UserExamp userExamp) async {
    var mesajID = _firestore.collection("users").document().documentID;
    Map _eklenecekMesajMAP = userExamp.toJson();
    _eklenecekMesajMAP["exampID"] = mesajID;

    var sonuc = await _firestore
        .collection("users")
        .document(userExamp.userID)
        .collection("sinavlarim")
        .document(mesajID)
        .setData(_eklenecekMesajMAP);
    UserExamp sonuc2 = UserExamp.fromJson(_eklenecekMesajMAP);
    print("database_firestore exampEkleDB return oldu");
    return sonuc2;
  }

  @override
  Future<User> readHasta(String userId) async {
    print("okunacak user readHasta:"+userId.toString());
    DocumentSnapshot _okunanUser =
        await Firestore.instance.document("users/${userId}").get();
    if (_okunanUser.data == null) {
      print("firesotoredB readUser Boş Döndü return oldu");
      return null;
    }
    Map okunanBilgileri = _okunanUser.data;
    User _okunanUserBilgileriNesnesi = User.fromJson(okunanBilgileri);
    //print("FS DB den kullanıcımız okundu : (JSON) : " +
    //   _okunanUserBilgileriNesnesi.toJson().toString());
    print("firesotoredB readUser return oldu Başarılı");
    return _okunanUserBilgileriNesnesi;
  }

  @override
  Future<List<HastaliklarModel>> readHastaliklar(BuildContext context) async {
    var gelenJSON = await DefaultAssetBundle.of(context)
        .loadString("lang/hastaliklarVeAnketleri.json");
    // debugPrint(gelenJSON.toString());

    List<HastaliklarModel> hastalikListesi = (json.decode(gelenJSON) as List)
        .map((mapim) => HastaliklarModel.fromJson(mapim))
        .toList();
    //print("Veriler Yüklendi : "+ hastalikListesi.length.toString()+" Adet Veri");
    return hastalikListesi;
  }

  @override
  Future<bool> hastaAnketOlurtur(
      BuildContext context,
      User aktifHasta,
      User doktor,
      HastaliklarModel hastaliklar,
      List<Anketler> anketler) async {
    //var mesajID = _firestore.collection("users").document().;
    //Map _eklenecekMesajMAP = userExamp.toJson();
    //_eklenecekMesajMAP["exampID"] = mesajID;

    List<Anketler> _anketListesi = new List<Anketler>();
    anketler.forEach((anket) {
      if (anket.secili == true) {
        _anketListesi.add(anket);
        print("Anket ID:" +
            anket.id.toString() +
            " Anket Name :" +
            anket.name +
            "Seçili :" +
            anket.secili.toString());
      }
    });
    List<AnketSorulariModelim> _listAnketSorulariModel =
        new List<AnketSorulariModelim>();
    _anketListesi.forEach((anketler) async {
      AnketSorulariModelim sorular =
          await readAnketSorulari(context, anketler.id);

      //Sorular çekiliyor-
      sorular.data.sorular.forEach((sorular) {
        print(
            "Anket Soruları Çekiliyor----------------------------------------------------");
        print("Soru :" + sorular.soru);
        sorular.secenekler.forEach((cevaplar) {
          // print("Element to string"+ cevaplar.toJson().toString());
          print("Seçenekler: " + cevaplar.secenek.toString());
          print("Puan: " + cevaplar.point.toString());
        });
      });
      //Sorular çekiliyor - Bitti
      //Veritabanına Kaydedilecek....

      var anketId = _firestore
          .collection("users")
          .document()
          .collection("anketler")
          .document()
          .documentID;
      var _anketMap = sorular.toJson();
      _anketMap["hastaDoktorAciklama"] = hastaliklar.doktorAciklama;
      _anketMap["doktorID"] = doktor.userID;
      _anketMap["cevaplamaTarihi"] = "";
      _anketMap["createDate"] = (DateTime.now().toString());

      var sonuc = await _firestore
          .collection("users")
          .document(aktifHasta.userID)
          .collection("anketler")
          .document(anketId)
          .setData(_anketMap);
    });
/*    anketler.forEach((anket) async {
      var mesajID = _firestore.collection("users").document().collection("anketler").document().documentID;
      var _anketMap = anket.toJson();
      _anketMap["hastaDoktorAciklama"] = hastaliklar.doktorAciklama;
      _anketMap["doktor"] = doktor.userID;

      var sonuc = await _firestore
          .collection("users")
          .document(aktifHasta.userID)
          .collection("anketler")
          .document(mesajID)
          .setData(_anketMap).then((value) async {
        List<AnketSorulariModel> anketteSorulacakSorular = await readAnketSorulari(context, anket.id);


      });


    });
    */
    //UserExamp sonuc2 = UserExamp.fromJson(_eklenecekMesajMAP);
    print("Hastaya Anketler Eklendi");
    return true;
  }

  @override
  Future<AnketSorulariModelim> readAnketSorulari(
      BuildContext context, int anketId) async {
    print("anket soruları yüklenmeye başlandı");
    var gelenJSON = await DefaultAssetBundle.of(context)
        .loadString("lang/anketler/" + anketId.toString() + ".json");

     debugPrint("GelenJSON:"+gelenJSON);
    var decodeJson = json.decode(gelenJSON);
    // print("decodeerrr :"+ decodeJson.toString());
    AnketSorulariModelim anketSorulariModelim =
        AnketSorulariModelim.fromJson(decodeJson);
    //.map((mapim) => HastaliklarModel.fromJson(mapim))
    //.toList();

    print("İşlem Bitti readAnketSorulari ");
    //print("Gelen Json :"+gelenJSON.toString());

    //print("Sonucummmmm :" + anketSorulariModelim.toJson().toString());
    //print("Anket Soruları Yüklendi : " +        anketSoruListesiRead.length.toString() +        " Adet Veri");
    return anketSorulariModelim;
  }

  @override
  Future<List<AnketSorulariModelim>> readAnketSorulariWithHastsa(
      User hasta) async {

    QuerySnapshot sorgum = await Firestore.instance
        .collection("users")
        .document("${hasta.userID}")
        .collection("anketler")
        .getDocuments();
    //.snapshots();
    var anketlistesi = sorgum.documents;
    List<AnketSorulariModelim> anketSorulariListeModelim = new List<AnketSorulariModelim>();
    anketlistesi.forEach((anket) {
      Map okunanAnket = anket.data;
      AnketSorulariModelim anketSorulariModelim = AnketSorulariModelim.fromJson(okunanAnket);
      anketSorulariModelim.docId = anket.documentID.toString();
      anketSorulariListeModelim.add(anketSorulariModelim);
    });
    //hastaAnketSorularimListSet = anketSorulariListeModelim;
    return anketSorulariListeModelim;

    /*
    print("Anketi okunacak Hasta :" + hasta.email);
    //DocumentSnapshot _okunanUser = await Firestore.instance.document("users/${hasta.userID}/").get();
    ///users/o4RLqy6Z4vcnyfRZmrnLmnBtt9m2/anketler/3eP7bbK4n6NzVAcmMMBx
    DocumentSnapshot _okunanUser = await Firestore.instance.document("users/${hasta.userID}/").get();
    //DocumentSnapshot _okunanUser = await Firestore.instance.document("users/${hasta.userID}").collection("anketler").document().get();
    //DocumentSnapshot _okunanUser = await Firestore.instance.collection("users").document("${hasta.userID}").get();


    var sorgum = Firestore.instance
        .collection("users")
        .document("${hasta.userID}")
        .collection("anketler")
        .snapshots();

    List<AnketSorulariModelim> anketSorulariModelimGonderilecek =
    new List<AnketSorulariModelim>();

      sorgum.listen((event) {
      print("***********************************************************");
      for (var anket in event.documents) {
        String docid = anket.documentID;
        //print("Doc id :"+ docid);
        // print("Bu ne : "+anket.toString());
        Map okunanAnket = anket.data;
        //print("okunanAnket :" + okunanAnket.toString());
        //FinalCoursesList.add(CourseModel.fromFireStore(Doc));
        AnketSorulariModelim anketim =
            AnketSorulariModelim.fromJson(okunanAnket);
        print("Anket Okundu");
        //print("Anket Okundu2 :"+ anketim.data.anketAdi);
        var sorular = anketim.data.sorular;
//        anketim.data.sorular
        sorular.forEach((soru) {
          print("Soru :" + soru.soru);
          var sorusecenekler = soru.secenekler;
          sorusecenekler.forEach((secenek) {
            print("   Seçenek :" + secenek.secenek);
          });
        });

        //anketim.data.sorular.
        // anketim.docId = docid;
        anketSorulariModelimGonderilecek.add(anketim);
        print("***********************************************************");
      }
    });
  print("İşlemler bitti");
   // print("HAKAN - anketSorulariModelimGonderilecek Sayı : "+ anketSorulariModelimGonderilecek.length.toString());
    //return anketSorulariModelimGonderilecek;

     */
  }

  @override
  Future<bool> writeAnketSorulari(BuildContext context,
      AnketSorulariModelim anketSorularim, User user) async {
    print("writeAnketSorulari  Çalıştı :");

    //Map _eklenecekUserMAP = user.toJson();
    Map _eklenecekUserMAP = anketSorularim.toJson();
    _eklenecekUserMAP["cevaplamaTarihi"] = DateTime.now().toString();
    //_eklenecekUserMAP["updateAT"] = FieldValue.serverTimestamp();
    print(
        "writeAnketSorulari Eklenecek Harita :" + _eklenecekUserMAP.toString());

    var sorgu = await _firestore
        .collection("users")
        .document(user.userID)
        .collection("anketler")
        .document(anketSorularim.docId)
        .setData(_eklenecekUserMAP);
      return true;
    //print("Sorgu Sonucu :"+sorgu)
    //Map okunanBilgileri = _okunanUser.data;
    //User _okunanUserBilgileriNesnesi = User.fromJson(okunanBilgileri);
    print("writeAnketSorulari saveUserDB return oldu Başarılı");
    return null;
  }

  @override
  Future<List<User>> readHastaListesi(User doktor) async {
    QuerySnapshot sorgum = await Firestore.instance
        .collection("users")
        .where("doktorID", isEqualTo: doktor.userID)
        .getDocuments();
//        .document("${hasta.userID}")
//        .collection("anketler")
//        .getDocuments();
    //.snapshots();
    print("Doktor ID: "+ doktor.userID);
    var hastalistesi = sorgum.documents;
    List<User> anketSorulariListeModelim = new List<User>();
    hastalistesi.forEach((anket) {
      Map okunanAnket = anket.data;
      User user = User.fromJson(okunanAnket);
      print("Okunan User : "+ user.userID);
      //anketSorulariModelim.docId = anket.documentID.toString();
      anketSorulariListeModelim.add(user);
    });
    //hastaAnketSorularimListSet = anketSorulariListeModelim;
    return anketSorulariListeModelim;
  }

  @override
  Future<User> updateUserDB(User user) async {

      await _firestore
          .collection("users")
          .document(user.userID)
          .updateData({
        "doktorID": user.doktorID,
        "adsoyad" : user.adsoyad,
        "boy" :user.boy,
        "cinsiyet" : user.cinsiyet,
        "kilo" : user.kilo,
        "yas" :user.yas

          }).then((value){
        //  print("database_firestore updateUserName Başarılı return oldu");
        //  return true;
      });

    print("database_firestore updateUserName Başarılı return oldu");
    return user;
  }
}
