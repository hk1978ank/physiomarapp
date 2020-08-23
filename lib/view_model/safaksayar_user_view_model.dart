import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/modeller/UserSafakSayar.dart';
import 'package:physiomarapp/modeller/kalanZaman.dart';
import 'package:physiomarapp/repostory/user_model_repostory.dart';
import 'package:physiomarapp/servisler/safaksayar_base_servis.dart';


import 'locatorSafakSayar.dart';

enum UserViewState { Bosta, Mesgul }

class SafaksayarUserViewModel    with ChangeNotifier    implements SafakSayarAuthUserBaseServisi {


  SafaksayarUserViewModel() {
    print("SafaksayarUserViewModel Oluşturuldu...");
    _kalanZaman = new  KalanZaman(gun: "0",saat: "0",dakika: "0",saniye: "0",milisaniye: "0",);
    print("Kalan Zaman Sıfırlandı");
    userSafakSayarModelSET= new UserSafakSayarModel(sayicalakTarih: DateTime.now());
  }

  

  UserModelSafakSayarRepo _userModelSafakSayarRepo = locator<UserModelSafakSayarRepo>();

  UserViewState _userViewState = UserViewState.Bosta;
  UserViewState get userViewState => _userViewState;
  set userViewState(UserViewState value) {
    _userViewState = value;
    notifyListeners();
  }

  UserSafakSayarModel _userSafakSayarModel;
  UserSafakSayarModel get userSafakSayarModelGET => _userSafakSayarModel;
  set userSafakSayarModelSET(UserSafakSayarModel value) {
    print("userSafakSayarModelSET Gelen $value");
    if (value == null) {
      _userSafakSayarModel.sayicalakTarih = DateTime.now();
      print("UVM userSafakSayarModelSET Gelen Value Null ");
    } else {
      _userSafakSayarModel = value;
      print("UVM _userSafakSayarModel Set Edildi");
    }
    notifyListeners();

  }

  KalanZaman _kalanZaman;


  KalanZaman get kalanZamanGET {
    if(_kalanZaman!=null)
      return _kalanZaman; else
        {
          return KalanZaman(gun: "0",saat: "0",dakika: "0",saniye: "0",milisaniye: "0",);
        }
  }

    set kalanZamanSET(KalanZaman value) {
      if(value==null) {
        _kalanZaman = KalanZaman(
          gun:"0",saat: "0",dakika: "0",saniye: "0",milisaniye: "0",
        );
      } else
        _kalanZaman = value;
      notifyListeners();
    }

    @override
    Future<UserSafakSayarModel> localDBOku() async {
      try {
        print("VM Local DB Oku Çağrıldı");
        UserSafakSayarModel sorgu = await _userModelSafakSayarRepo.localDBOku();
        userSafakSayarModelSET = sorgu;
        print("VM Veri LocalDB okundu işlem Bitti");
      } catch (e) {
        print("UVM localDBOku-error :" + e.toString());
      }
      return null;
    }

    @override
    Future<UserSafakSayarModel> localDBYaz(DateTime tarih) async {
      try {
        var sorgu = await _userModelSafakSayarRepo.localDBYaz(tarih);
        userSafakSayarModelSET = sorgu;
        print("VM Veri localDBYaz okundu işlem Bitti");
      } catch (e) {
        print("UVM localDBOku-error :" + e.toString());
      }
      return null;
    }

    @override
    Future<DateTime> tarihVeSaatiBirlestir(DateTime birlestirilecekTarih, DateTime birlestirilecekSaat) async {
      try {
        var sorgu = await _userModelSafakSayarRepo.tarihVeSaatiBirlestir(birlestirilecekTarih, birlestirilecekSaat);
        print("VM Veri tarihVeSaatiBirlestir Sonuölandı. Birleşen Tarih :"+sorgu.toString());
         UserSafakSayarModel sonuc = await localDBYaz(sorgu);
         userSafakSayarModelSET = sonuc;
        return sorgu;
      } catch (e) {
        print("UVM tarihVeSaatiBirlestir-error :" + e.toString());
      }
      return null;
    }
  }
 

