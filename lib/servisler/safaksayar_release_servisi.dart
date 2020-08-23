
import 'package:physiomarapp/modeller/UserSafakSayar.dart';
import 'package:physiomarapp/servisler/safaksayar_base_servis.dart';

class SafakSayarReleaseServisi implements SafakSayarAuthUserBaseServisi{

  @override
  Future<UserSafakSayarModel> localDBOku() async {


      return null;
  }

  @override
  Future<UserSafakSayarModel> localDBYaz(DateTime tarih) async {
return null;
  }

  @override
  Future<DateTime> tarihVeSaatiBirlestir(DateTime birlestirilecekTarih, DateTime birlestirilecekSaat) async {
    int gun, ay, saatt, dakika, saniye;
    String gunS, ayS, saatS, dakikaS, saniyeS;
    gun = birlestirilecekTarih.day;
    ay = birlestirilecekTarih.month;
    saatt = birlestirilecekSaat.hour;
    dakika = birlestirilecekSaat.minute;
    saniye = birlestirilecekSaat.second;

    if (gun < 10)
      gunS = "0" + gun.toString();
    else
      gunS = gun.toString();
    if (ay < 10)
      ayS = "0" + ay.toString();
    else
      ayS = ay.toString();

    if (saatt < 10)
      saatS = "0" + saatt.toString();
    else
      saatS = saatt.toString();
    if (dakika < 10)
      dakikaS = "0" + dakika.toString();
    else
      dakikaS = dakika.toString();
    if (saniye < 10)
      saniyeS = "0" + saniye.toString();
    else
      saniyeS = saniye.toString();

    String tarihhh = birlestirilecekTarih.year.toString() + "-" + ayS + "-" + gunS;
    String saatttt = saatS + ":" + dakikaS + ":" + saniyeS;
    String sonTarihString = tarihhh + " " + saatttt;

    DateTime gonderilecekTarihSaat = DateTime.parse(tarihhh + " " + saatttt + "");
    return gonderilecekTarihSaat;
  }


}