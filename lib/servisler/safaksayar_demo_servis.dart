
import 'package:physiomarapp/modeller/UserSafakSayar.dart';
import 'package:physiomarapp/servisler/safaksayar_base_servis.dart';

class SafakSayarDemoServisi implements SafakSayarAuthUserBaseServisi{
  @override
  Future<UserSafakSayarModel> localDBOku() async {
    UserSafakSayarModel safak = UserSafakSayarModel(
        sayicalakTarih:DateTime.now(),
    );
    return safak;
  }

  @override
  Future<UserSafakSayarModel> localDBYaz(DateTime tarih) async {
    UserSafakSayarModel safak = UserSafakSayarModel(
        sayicalakTarih : tarih,
    );
    return safak;
  }

  @override
  Future<DateTime> tarihVeSaatiBirlestir(DateTime birlestirilecekTarih, DateTime birlestirilecekSaat) async {
    // TODO: implement tarihVeSaatiBirlestir

   return  DateTime.now();
  }




}