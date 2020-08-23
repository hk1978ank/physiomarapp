import 'dart:async';

import 'package:flutter/cupertino.dart';

class KalanZamanHesapla{

  Timer _timer;
  String gelenTarih;

  String gun;
  String saat;
  String dakika;
  String saniye;
  String milisaniye;
  String _gidenZaman;

  KalanZamanHesapla({@required this.gelenTarih})
  {
   // print("Kalan Zaman Nesnesi Oluşturuldu... =============");
  }

  set gidenZamanSET(String value) {
    _gidenZaman = value;
  }

  String get gidenZamanGET => _gidenZaman;

  KalanZaman ZamaniHesapLaToString() {
    if(gelenTarih==null)
      return null;
    KalanZaman goster = ZamaniHesapla(gelenTarih);
    return goster;
  }

  KalanZaman ZamaniHesapla(String gelenTarihString) {

    int kalanGun = 0;
    int kalanSaat = 0;
    int kalanDakika = 0;
    int kalanSaniye = 0;
    int kalanMiliSaniye = 0;

    DateTime gelenTarih = DateTime.parse(gelenTarihString);
    DateTime bugun = DateTime.now();

    Duration totalFark = gelenTarih.difference(bugun);
    kalanDakika = totalFark.inMinutes;
    kalanSaniye = totalFark.inSeconds;
    kalanMiliSaniye = totalFark.inMilliseconds;
    kalanSaat = totalFark.inHours;
    kalanGun = totalFark.inDays;

    var kalanZaman = KalanZaman(
      gun: kalanGun.toString(),
      saat: kalanSaat.toString(),
      dakika: kalanDakika.toString(),
      saniye: kalanSaniye.toString(),
      milisaniye: kalanMiliSaniye.toString(),
      uzunGoster: "$kalanGun Gün $kalanSaat Saat $kalanDakika Dakika $kalanSaniye",
    );

    if(true)
      {

        return kalanZaman;
      }

  }



}
class KalanZaman{
  String gun;
  String saat;
  String dakika;
  String saniye;
  String milisaniye;
  String uzunGoster;
  KalanZaman({this.gun, this.saat, this.dakika, this.saniye, this.milisaniye,this.uzunGoster});
}