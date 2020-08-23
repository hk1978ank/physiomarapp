import 'package:flutter/material.dart';
import 'package:physiomarapp/modeller/UserSafakSayar.dart';
import 'package:physiomarapp/servisler/safaksayar_base_servis.dart';
import 'package:physiomarapp/servisler/safaksayar_demo_servis.dart';
import 'package:physiomarapp/servisler/safaksayar_release_servisi.dart';
import 'package:physiomarapp/view_model/locatorSafakSayar.dart';

enum CalismaModu {Relase,Demo }

class UserModelSafakSayarRepo with ChangeNotifier implements SafakSayarAuthUserBaseServisi
{
  CalismaModu calismaModu = CalismaModu.Relase;

  SafakSayarDemoServisi _safakSayarDemoServisi =  locator<SafakSayarDemoServisi>();
  SafakSayarReleaseServisi _safakSayarReleaseServisi =  locator<SafakSayarReleaseServisi>();

  @override
  Future<UserSafakSayarModel> localDBOku()  async {
    if ( calismaModu == CalismaModu.Demo) {
      var sonuc = await _safakSayarDemoServisi.localDBOku();
      return sonuc;
    }
    if ( calismaModu == CalismaModu.Relase) {
      var sonuc = await _safakSayarReleaseServisi.localDBOku();
      return sonuc;
    }
    return null;
  }

  @override
  Future<UserSafakSayarModel> localDBYaz(DateTime tarih) async {
    if ( calismaModu == CalismaModu.Demo) {
      var sonuc = await _safakSayarDemoServisi.localDBYaz(tarih);
      return sonuc;
    }
    if ( calismaModu == CalismaModu.Relase) {
      var sonuc = await _safakSayarReleaseServisi.localDBYaz(tarih);
      return sonuc;
    }
    return null;
  }

  @override
  Future<DateTime> tarihVeSaatiBirlestir(DateTime birlestirilecekTarih, DateTime birlestirilecekSaat) async {
    if ( calismaModu == CalismaModu.Demo) {
      var sonuc = await _safakSayarDemoServisi.tarihVeSaatiBirlestir(birlestirilecekTarih, birlestirilecekSaat);
      return sonuc;
    }
    if ( calismaModu == CalismaModu.Relase) {
      var sonuc = await _safakSayarReleaseServisi.tarihVeSaatiBirlestir(birlestirilecekTarih, birlestirilecekSaat);
      return sonuc;
    }

  }


}