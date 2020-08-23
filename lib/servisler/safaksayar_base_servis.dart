
import 'package:physiomarapp/modeller/UserSafakSayar.dart';

abstract class SafakSayarAuthUserBaseServisi
{
 // Future<UserSafakSayar> signInUserNameAndPassword(String username, String password)
  Future<DateTime> tarihVeSaatiBirlestir(DateTime birlestirilecekTarih,DateTime birlestirilecekSaat);
  Future<UserSafakSayarModel> localDBYaz(DateTime tarih);
  Future<UserSafakSayarModel> localDBOku();

}