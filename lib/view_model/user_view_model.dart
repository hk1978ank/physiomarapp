import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:physiomarapp/modeller/anket_sorulari_model.dart';
import 'package:physiomarapp/modeller/hastaliklar.dart';
import 'package:physiomarapp/modeller/user_chat_room.dart';
import 'package:physiomarapp/modeller/user_examp.dart';
import 'package:physiomarapp/modeller/user_model.dart';
import 'file:///C:/APROJELER/Android/hakankucuk.com.app/physiomarapp/lib/sayfalar/hasta_islemleri.dart';
import 'package:physiomarapp/repostory/user_auth_repostory.dart';
import 'package:physiomarapp/repostory/user_db_repostory.dart';
import 'package:physiomarapp/repostory/user_strorage_repostory.dart';
import 'package:physiomarapp/servisler/database_base.dart';
import 'package:physiomarapp/servisler/storage_base.dart';
import 'package:physiomarapp/servisler/user_auth_base_servis.dart';
import 'package:physiomarapp/view_model/locatorSafakSayar.dart';


enum ViewState { Bosta, Mesgul }

class UserViewModel
    with ChangeNotifier
    implements UserAuthBaseServis, DBBase, FileStorageBase {
  ViewState _statee = ViewState.Bosta;
  User _user;
  User _hasta;
  DateTime _sayilacakTarih;
  String _baglanilacakOda;


  List<User> _hastaListesi;


  List<User> get hastaListesiGET => _hastaListesi;

  set hastaListesiSET(List<User> value) {
    print("Hasta Listesi Set edilecek");
    _hastaListesi = value;
    print("Hasta Listesi Set Edildi");

  }

  HastaliklarModel _aktifHastalik;
  HastaliklarModel get aktifHastalikGET => _aktifHastalik;

  set aktifHastalikSET(HastaliklarModel value) {
    _aktifHastalik = value;
  }

  List<AnketSorulariModelim> _hastaAnketSorularim = new List<AnketSorulariModelim>();


  List<AnketSorulariModelim> get hastaAnketSorularimListGET => _hastaAnketSorularim;

  set hastaAnketSorularimListSet(List<AnketSorulariModelim> value) {
    if(value!=null)
    {
      print("Hasta anket sonuçları Set Edildi...:"+value.length.toString());
      _hastaAnketSorularim = value;

    } else {
      print("Hasta anket sonuçları Set Edildi...Boş:");
      _hastaAnketSorularim = null;

    }
  }

  AnketSorulariModelim _anketSorulari;
  AnketSorulariModelim get anketSorulariGET => _anketSorulari;

  set anketSorulariSET(AnketSorulariModelim value) {
    _anketSorulari = value;
    print("Hasta Anket soruları set edildi");
  }

  List<Anketler> _anketListesiAll = [];
  List<Anketler> get anketListesiAllGET => _anketListesiAll;
  set anketListesiAllSET(List<Anketler> value) {
    _anketListesiAll = value;
    if(value!=null)
      {
        _anketListesiAll.sort((a, b) {
          return a.name.toString().toLowerCase().compareTo(b.name.toString().toLowerCase());
        });
      }


  }
  set anketListesiAllAddSET(Anketler value) {

    print("Eklenecek Anket : "+ value.toJson().toString());
    _anketListesiAll.add(value);
  }

  List<HastaliklarModel> _hastaliklarListem;
  List<HastaliklarModel> get hastaliklarListemGET => _hastaliklarListem;
  set hastaliklarListemSET(List<HastaliklarModel> value) {
    _hastaliklarListem = value;
    //print("Anketler ve hatalıklar yüklendi2");


    //print("Anketler ve hatalıklar yüklendi3");
  }
  set hastaliklarListemSETByID(HastaliklarModel value) {

    _hastaliklarListem.forEach((element) {
      //print("Element id :"+ element.id.toString());
      //print("Value id :"+ value.id.toString());
      if(value.id==element.id)
        {
          element.secili = true;
          aktifHastalikSET = element;

        } else{element.secili = false;}
    });
    //print("Buradayız:"+ value.id.toString() + " Seçili : "+ value.secili.toString());
    //_hastaliklarListem
    _hastaliklarListem[value.id-1].secili = value.secili;
  }



  DateTime get sayilacakTarihGET {
   // print("Ger Tarih çalıştı");
    if(_sayilacakTarih==null){
      var sonuc =DateTime.now();
     // ChangeNotifier();
      return sonuc;
    }  else
      {
        var sonuc2 =_sayilacakTarih;
     //   ChangeNotifier();
        return sonuc2;
      }

  }

  set sayilacakTarihSET(DateTime value) {
    _sayilacakTarih = value;
    ChangeNotifier();
  } //Sayılacak Tarih İşlemleri


 // String testDevices = 'ca-app-pub-4642109129882786~5948344646';



  //List<String> dilDestegi = ["tr", "en","de","ru","fr"];
  List<String> dilDestegi = ["tr","en"];
  String _dilDosyasiJSON;
  String _defaultLocation ="en";
  Map<String, String> _localizedStrings;

  Map<String, String> get localizedStringsGET => _localizedStrings;

  set localizedStringsSET(Map<String, String> value) {
    _localizedStrings = value;
  }

  _dilDosyasiniYUKLE(String myLocale) async {
   print("Default Konuşma Dili : "+myLocale);
    _defaultLocation=myLocale;
    bool destekSaglaniyormu = dilDestegi.contains(myLocale);
    if(destekSaglaniyormu)
    {
      //print("Destek Sağlanıyor...");
      String jsonString  =  await rootBundle.loadString("lang/$myLocale.json");
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      localizedStringsSET = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
    }
    else
    {
      print("Destek Sağlanmıyor...==========");
      String jsonString =  await rootBundle.loadString("lang/en.json");
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      localizedStringsSET = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
    }
  }


  String translate(String CevrileekMetin,BuildContext context)
  {
    String ceviriSonucu=CevrileekMetin;
    Locale myLocale = Localizations.localeOf(context);
    String myLocaleLanguageCode = myLocale.languageCode.toString();
   // print("LOCATIONSSS :"+myLocale.toString() + " Default Olan : "+ _defaultLocation);
    if(true || localizedStringsGET==null || _defaultLocation!=myLocaleLanguageCode) _dilDosyasiniYUKLE(myLocaleLanguageCode);
    if(localizedStringsGET!=null)
      {
        return localizedStringsGET[CevrileekMetin];

      } else
        {
          return CevrileekMetin;
        }

    //return gelen+" "+myLocale.toString();
  }



  List<String> _hataListesi = List<String>();
  List<String> get hataListesiGET => _hataListesi;

  set hataListesiAddSET(String value) {
    _hataListesi.add(value);
  }

  UserExamp _examp;
  List<UserExamp> _exampList;

  List<UserExamp> get exampListGET => _exampList;

  set exampListSET(List<UserExamp> value) {
    if(value!=null)
    if(value.length>0) {
      value.forEach((element) {
        if(element.primary) sayilacakTarihSET=DateTime.parse(element.examTarih);
      });
    }
    _exampList = value;
  }

  set exampListAddSET(UserExamp value) {
    _exampList.add(value);
  }

  UserExamp get exampGET => _examp;
  set exampSET(UserExamp value) {
    _examp = value;
  }

  UserAuthRepostory _userAuthRepostory = locator<UserAuthRepostory>();
  UserDbRepostory _userDbRepostory = locator<UserDbRepostory>();
  FileStorageRepostory _fileStorageRepostory = locator<FileStorageRepostory>();

  set baglanilacakOdaSET(String value) {
    if(value==null || value=="") _baglanilacakOda="genel";
    if (userGET == null) {
      _baglanilacakOda = value.toLowerCase().toLowerCase();
    } else {
      _baglanilacakOda = value.toLowerCase().trim();
    }
  }

  User get userGET => _user;

  set userSET(User value) {
    _user = value;
    notifyListeners();
  }

  User get hastaGET => _hasta;
  set hastaSET(User value) {
    _hasta = value;
    notifyListeners();
  }

  ViewState get stateGET => _statee;

  set stateSET(ViewState value) {
    _statee = value;
    notifyListeners();
  }

  UserViewModel() {
    print("USER VİEW MODEL OLUŞTURULDU ===============================");
    currentUser();


  }

  @override
  Future<bool> signOutUser() async {
    userSET = null;
    hastaSET = null;
    hastaListesiSET = null;
    anketListesiAllSET = null;
    aktifHastalikSET = null;
    anketSorulariSET = null;
    hastaliklarListemSET = null;

    try {
      stateSET = ViewState.Mesgul;
      var sonuc = await _userAuthRepostory.signOutUser();
      print("Bura çalıştı");
      return sonuc;
    } catch (e) {
      print("singOutUser da hata çıktı :" + e.toString());
    } finally {
        exampListSET = null;
        userSET = null;
        stateSET = ViewState.Bosta;
    }

  }

  @override
  Future<User> signInAnonimusUser() async {
    try {
      stateSET = ViewState.Mesgul;
      User _user;
      User sonuc = await _userAuthRepostory.signInAnonimusUser();
      if (sonuc != null) {
        var _kullaniciDBdeVarmi = await readUser(sonuc.userID);
        if (_kullaniciDBdeVarmi == null) {
          // sonuc.email = "anonim@mail.com";
          _user = await saveUserDB(sonuc);
          await createTestSinav(_user);
        } else {
          _user = _kullaniciDBdeVarmi;
        }
        await exampListesiGetirDB(sonuc.userID);
        // 1- bu user db de var mı checkEdilecek yok ise oluşturulacak var ise db deki veriler getirilecek...
      } else {}
      userSET = _user;
      return _user;
    } catch (e) {} finally {
      stateSET = ViewState.Bosta;
    }
  }

  @override
  Future<User> currentUser() async {
    try {
      stateSET = ViewState.Mesgul;
      User _user;
      User sonuc = await _userAuthRepostory.currentUser();
      if (sonuc != null) {
        var _kullaniciDBdeVarmi = await readUser(sonuc.userID);
        if (_kullaniciDBdeVarmi == null) {
          _user = await saveUserDB(sonuc);
        } else {
          _user = _kullaniciDBdeVarmi;
        }
        userSET = _user;
        if(_user.tur!="Doktor")
          {
            print("Mevcut kullanıcı bir hasta :"+ _user.email.toString());
            hastaSET =_user;
          }
        await exampListesiGetirDB(sonuc.userID);
      }

      return _user;
    } catch (e) {
      print("Current User Sorgusu Hata :" + e.toString());
    } finally {
      stateSET = ViewState.Bosta;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      stateSET = ViewState.Mesgul;
      User _user;
      User sonuc = await _userAuthRepostory.signInWithGoogle();

      if (sonuc != null) {

        var _kullaniciDBdeVarmi = await readUser(sonuc.userID);
        if (_kullaniciDBdeVarmi == null) {
          _user = await saveUserDB(sonuc);
          await createTestSinav(_user);
        } else {
          _user = _kullaniciDBdeVarmi;
        }
        await exampListesiGetirDB(sonuc.userID);
        // 1- bu user db de var mı checkEdilecek yok ise oluşturulacak var ise db deki veriler getirilecek...
      } else {}
      userSET = _user;
      return _user;
    } catch (e) {} finally {
      stateSET = ViewState.Bosta;
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    /*
    stateSET = ViewState.Mesgul;
    User _user;
    try {
      User sonuc = await _userAuthRepostory.signInWithFacebook();
      if (sonuc != null) {

        var _kullaniciDBdeVarmi = await readUser(sonuc.userID);
        if (_kullaniciDBdeVarmi == null) {
          _user = await saveUserDB(sonuc);
          await createTestSinav(_user);
        } else {
          _user = _kullaniciDBdeVarmi;
        }
        await exampListesiGetirDB(sonuc.userID);
      }
      userSET = _user;
      return _user;
    } catch (e) {
      print("signInWithFacebook da hata : " + e.toString());
      return User(
        email: "hata",
        userID: "Hata",
        latessRommName: "genel",
        profilURL: "",
        hata:"viewde hata :",
        hata2: e.toString(),
      );
    } finally {
      stateSET = ViewState.Bosta;
    }*/
    return null;
  }

  @override
  Future<User> readUser(String userId) async {
    try {
      stateSET = ViewState.Mesgul;
      var sorgu = await _userDbRepostory.readUser(userId);
      userSET = sorgu;
      if(sorgu.tur=="Hasta")
        {
          hastaSET = sorgu;
        }
      return sorgu;
    } catch (e) {
      print("Read User da Hata :" + e.toString());
    } finally {
      stateSET = ViewState.Bosta;
    }
    return Future.value(null);
  }

  @override
  Future<User> saveUserDB(User user) async {
    try {
      print("saveUserDB viewModeldeyiz User :" + user.toJson().toString());
      stateSET = ViewState.Mesgul;

      var sorgu = await _userDbRepostory.saveUserDB(user);
      userSET = sorgu;
      return sorgu;
    } catch (e) {
      print("SaveUserDB de hata :" + e.toString());
    } finally {
      stateSET = ViewState.Bosta;
    }
    return Future.value(null);
  }

  @override
  Future<bool> updateUserName(String userID, String yeniUserName) async {
    /*
    try {
      stateSET = ViewState.Mesgul;
      var sorgu = await _userDbRepostory.updateUserName(userID, yeniUserName);
      if (sorgu) {
        User _user = userGET;
        _user.userName = yeniUserName;
        userSET = _user;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("updateUserName de hata :" + e.toString());
    } finally {
      stateSET = ViewState.Bosta;
    }
    return Future.value(false);

     */
    return Future.value(false);
  }

  @override
  Future<String> uploadFile(String userID, String fileType, File file) async {
    try {
      stateSET = ViewState.Mesgul;
      var sorgu =
          await _fileStorageRepostory.uploadFile(userID, fileType, file);
      if (sorgu != null) {
        var dbprofilFotoUrlGuncelle = await updateUserprofilUrl(userID, sorgu);
      }

      return sorgu;
    } catch (e) {
      print("uploadFile hata oluştu :" + e.toString());
    } finally {
      stateSET = ViewState.Bosta;
    }
  }

  @override
  Future<bool> updateUserprofilUrl(String userID, String yeniURL) async {
    /*
    try {
      stateSET = ViewState.Mesgul;
      var sorgu = await _userDbRepostory.updateUserprofilUrl(userID, yeniURL);
      if (sorgu) {
        User _user = userGET;
        _user.profilURL = yeniURL;
        userSET = _user;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("updateUserprofilUrl hata oluştu :" + e.toString());
    } finally {
      stateSET = ViewState.Bosta;
    }
    return Future.value(false);
     */
    return Future.value(false);
  }

  @override
  Stream<QuerySnapshot> getRoomMessage(String roomName, User user) {
    print("Get Room Message");
    return _userDbRepostory.getRoomMessage(roomName, user);
  }

  @override
  Future<bool> sendMessage(
      String roomName, User user, UserRoomMessage userRoomMessage) async {
    try {
      stateSET = ViewState.Mesgul;
      var sorgu =
          await _userDbRepostory.sendMessage(roomName, user, userRoomMessage);
      return sorgu;
    } catch (e) {
      print("sendMessage hata oluştu :" + e.toString());
    } finally {
      stateSET = ViewState.Bosta;
    }
    return Future.value(false);
  }

  @override
  Future<bool> updateLastRoomName(String userID, String yeniRoom) async {
    try {
      stateSET = ViewState.Mesgul;
      var sorgu = await _userDbRepostory.updateLastRoomName(userID, yeniRoom);
      return true;
    } catch (e) {
      print("updateLastRoomName hata oluştu :" + e.toString());
    } finally {
      stateSET = ViewState.Bosta;
    }
    return Future.value(false);
  }

  @override
  Future<UserExamp> exampGetirDB(String exampID) async {
    stateSET = ViewState.Mesgul;
    try {
      UserExamp sonuc = await _userDbRepostory.exampGetirDB(exampID);
      exampSET = sonuc;
      return sonuc;
    } catch (e) {
      print("updateLastRoomName hata oluştu :" + e.toString());
      exampSET = null;
    } finally {
      stateSET = ViewState.Bosta;
    }
  }

  @override
  Future<UserExamp> exampGuncelleDB(UserExamp userExamp) async {
    try {
      stateSET = ViewState.Mesgul;
      UserExamp sonuc = await _userDbRepostory.exampGuncelleDB(userExamp);
      exampSET = sonuc;
      await exampListesiGetirDB(sonuc.userID);
      return sonuc;
    } catch (e) {
      print("exampGuncelleDB hata oluştu :" + e.toString());
      exampSET = null;
    } finally {
      stateSET = ViewState.Bosta;
    }
  }

  @override
  Future<List<UserExamp>> exampListesiGetirDB(String userID) async {
    try {
      stateSET = ViewState.Mesgul;
      List<UserExamp> sonuc =
          await _userDbRepostory.exampListesiGetirDB(userID);
      exampListSET = sonuc;
      return sonuc;
    } catch (e) {
      print("exampListesiGetirDB hata oluştu :" + e.toString());
      exampListSET = null;
    } finally {
      stateSET = ViewState.Bosta;
    }
  }

  @override
  Future<UserExamp> exampSilDB(UserExamp userExamp) async {
    try {
      stateSET = ViewState.Mesgul;
      UserExamp sonuc = await _userDbRepostory.exampSilDB(userExamp);
      exampSET = sonuc;
      await exampListesiGetirDB(sonuc.userID);
      return sonuc;
    } catch (e) {
      print("exampSilDB hata oluştu :" + e.toString());
      exampSET = null;
    } finally {
      stateSET = ViewState.Bosta;
    }
  }

  @override
  Future<UserExamp> exampEkleDB(UserExamp userExamp) async {
    try {
      stateSET = ViewState.Mesgul;
      UserExamp sonuc = await _userDbRepostory.exampEkleDB(userExamp);
      exampSET = sonuc;
      await exampListesiGetirDB(sonuc.userID);
      return sonuc;
    } catch (e) {
      print("exampEkleDB hata oluştu :" + e.toString());
      exampSET = null;
    } finally {
      stateSET = ViewState.Bosta;
    }
    return null;
  }

  createTestSinav(User _user) async {
    UserExamp userExamp = UserExamp(
      userID: _user.userID,
      exampSira: 0,
      exampRoom: "genel",
      exampID: null,
      exampbaslik: localizedStringsGET["sinavlarim_ornek_baslik"],
      examTarih:"2021-01-01 00:00:00.000",
      primary: true,
    );
    print("Yazılacak Examp:"+userExamp.toJson().toString());
    await exampEkleDB(userExamp);

  }

  @override
  Future<bool> createHastaPassword(String _username,String _password,String _adsoyad,
      String _cinsiyet,String _yas,String _boy,  String _kilo) async {
    User userss;
    print("CreateHastaPasswod : $_username, $_password, $_adsoyad, $_cinsiyet, $_yas, $_boy, $_kilo");
    try{
      User sonuc = await _userAuthRepostory.createEmailPassword(_username, _password);
      userss = sonuc;
    } catch(e)
    {
      return false;
    }
    if (userss != null) {
        print("Create İşlemi Başarılı: Şimdi DB de kullanıcı varmı kontrol edilecek.");
        var _kullaniciDBdeVarmi = await readUser(userss.userID);
        if (_kullaniciDBdeVarmi == null) {
          print("Kullanıcı DB de yok ");
          userss.adsoyad = _adsoyad;
          userss.cinsiyet = _cinsiyet;
          userss.yas = _yas;
          userss.boy = _boy;
          userss.kilo = _kilo;
          userss.tur="Hasta";
          //userss.boy = _boy;
          //userss.kilo
          print("Buradayız...3.");
          userss = await saveUserDB(userss);
        } else {
          userss = _kullaniciDBdeVarmi;
        }
      userSET = userss;
      print("create email view runn6");
      return true;
    }

  }


  @override
  Future<User> createEmailPassword(String email, String password) async {
    print("create email view runn1");
    try {
      stateSET = ViewState.Mesgul;
      User _user;
      print("create email view runn2");
      User sonuc = await _userAuthRepostory.createEmailPassword(email, password);
      print("create email view runn3");
      if (sonuc != null) {
        print("Create İşlemi Başarılı: Şimdi DB de kullanıcı varmı kontrol edilecek.");
        var _kullaniciDBdeVarmi = await readUser(sonuc.userID);
        if (_kullaniciDBdeVarmi == null) {
          // sonuc.email = "anonim@mail.com";
          print("Kullanıcı DB ye saklanacak");
          _user = await saveUserDB(sonuc);
          print("Kullanıcı DB ye saklalandı2");
          //await createTestSinav(_user);
        } else {
          _user = _kullaniciDBdeVarmi;
        }
        //await exampListesiGetirDB(sonuc.userID);
        // 1- bu user db de var mı checkEdilecek yok ise oluşturulacak var ise db deki veriler getirilecek...
      } else {

      }
      userSET = _user;
      print("create email view runn6");


      return _user;
    }
    catch (e) {
      print("Create Email hatalar oluştu : View Model : "+ e.toString());
    } finally {
      stateSET = ViewState.Bosta;
    }
  }

  @override
  Future<User> signInEmailPassword(String email, String password) async {
    try {
      print("Sign in çalıştı");
      stateSET = ViewState.Mesgul;
      User _user;
      User sonuc = await _userAuthRepostory.signInEmailPassword(email, password);
      if (sonuc != null) {
        print("signEmailPassword email view runn4");
        User _userDB = await _userDbRepostory.readUser(sonuc.userID);
        print("signEmailPassword email view runn 4.5");
       userSET = _userDB;
      } else {

        print("signEmailPassword email view runn5");
        userSET = null;
      }
      //userSET = _user;
      //userSET = _user;
      return _user;
    }
    catch (e) {

    } finally {
      stateSET = ViewState.Bosta;
    }
  }

  @override
  Future<User> readHasta(String userId) async {
    try {
   //   stateSET = ViewState.Mesgul;
      var sorgu = await _userDbRepostory.readUser(userId);
      if(sorgu!=null)
        {
        //  print("Gelen Hasta:"+ sorgu.toJson().toString());
        }
      hastaSET = sorgu;
      return sorgu;
    } catch (e) {
      print("Read User da Hata :" + e.toString());
    } finally {
      stateSET = ViewState.Bosta;
    }
    return Future.value(null);
  }

  @override
  Future<List<HastaliklarModel>> readHastaliklar(BuildContext context) async {
    print("Read Hastalıklar Çalıştı");
    try {
      //   stateSET = ViewState.Mesgul;
      var sorgu = await _userDbRepostory.readHastaliklar(context);
      hastaliklarListemSET = sorgu;
      print("Hastlaıklar OK");

/*
      List<Anketler> anketListesi2 = new List<Anketler>();
      for(var i = 1; i < 39; i++){
        print("i sayac "+ i.toString());
        var anketSorulariModelim =  await _userDbRepostory.readAnketSorulari(context, i).then((anketSorulariModelim){
          print("Anket sorularım:"+ anketSorulariModelim.toJson().toString());
          Anketler ankett;
          ankett.id = anketSorulariModelim.data.id;
          ankett.name = anketSorulariModelim.data.anketAdi;
          ankett.secili = false;
          anketListesi2.add(ankett);

        });
      }
      anketListesiAllSET = anketListesi2;
      print("Burada");
      */
      List<Anketler> anketListesi = new List<Anketler>();
      hastaliklarListemGET.forEach((element) {
        element.anketler.forEach((element2) {
          print("Hastalık Listem Anketler Id:"+ element2.id.toString());
          anketListesi.add(element2);
        });
      });

      List<Anketler> anketListesi2 = new List<Anketler>();

      for(var i = 1; i < 39; i++){
        bool eklendi = true;
        anketListesi.forEach((element) {

              if(element.id==i && eklendi){
                print("Eklenen ID :"+ i.toString());
                anketListesi2.add(element);
                eklendi = false;
              }
        });
      }
      anketListesiAllSET = anketListesi2;

      //anketListesiAllSET = anketListesi;

      print("Anket yükleme All ok. Toplam Anket:"+ anketListesiAllGET.length.toString());
      return sorgu;
    } catch (e) {
      print("Read User da Hata :" + e.toString());
    } finally {
      //stateSET = ViewState.Bosta;
    }
    return Future.value(null);
  }

  @override
  Future<bool> hastaAnketOlurtur(BuildContext context,User aktifHasta,User doktor, HastaliklarModel hastaliklar, List<Anketler> anketler) async {
    try {
      print("View Hasta Anket Oluştur Başladı");
      var sorgu = await _userDbRepostory.hastaAnketOlurtur(context, aktifHasta, doktor, hastaliklar, anketler);
      return sorgu;
    } catch (e) {
      print("Hasta Anket Oluşturma Hatası :" + e.toString());
    } finally {
      //stateSET = ViewState.Bosta;
    }
    return Future.value(false);
  }

  @override
  Future<AnketSorulariModelim> readAnketSorulari(BuildContext context, int anketId) async {
    try {
      print("View Hasta readAnketSorulari Anket Oluştur Başladı");
      var sorgu = await _userDbRepostory.readAnketSorulari(context, anketId);
      anketSorulariSET = sorgu;
      return sorgu;
    } catch (e) {
      print("readAnketSorulari Hata :" + e.toString());
    } finally {
      //stateSET = ViewState.Bosta;
    }
    return null;
    // return Future.value(false);
  }

  @override
  Future<List<AnketSorulariModelim>> readAnketSorulariWithHastsa(User hasta) async {
    try {
     // print("View readAnketSorulariWithHastsa  Başladı"+ hasta.toJson().toString());
      var sorgu = await _userDbRepostory.readAnketSorulariWithHastsa(hasta);
      hastaAnketSorularimListSet = sorgu;
      print("View readAnketSorulariWithHastsa  Bitti");
      return sorgu;
    } catch (e) {
      print("readAnketSorulariWithHastsa Hata2 :" + e.toString());
      anketListesiAllSET = null;
    } finally {
      //stateSET = ViewState.Bosta;
    }
    return null;

  }

  @override
  Future<bool> writeAnketSorulari(BuildContext context, AnketSorulariModelim anketSorularim, User hasta) async {
    try {
      print("View readAnketSorulariWithHastsa  Başladı");
      var sorgu = await _userDbRepostory.writeAnketSorulari(context, anketSorularim, hasta);
      return sorgu;
    } catch (e) {
      print("readAnketSorulariWithHastsa Hata :" + e.toString());

    } finally {

    }
    return false;
  }

  @override
  Future<List<User>> readHastaListesi(User doktor) async {
    try {
      print("readHastaListesi  Başladı");
      var sorgu = await _userDbRepostory.readHastaListesi(doktor);
      hastaListesiSET = sorgu;
      return sorgu;
    } catch (e) {
      print("readHastaListesi Hata :" + e.toString());

    } finally {

    }
    return null;
  }

  @override
  Future<User> updateUserDB(User user) async {
    try {
      print("updateUserDB  Başladı");
      var sorgu = await _userDbRepostory.updateUserDB(user);
      return sorgu;
    } catch (e) {
      print("updateUserDB Hata :" + e.toString());
    } finally {

    }
  }







}
