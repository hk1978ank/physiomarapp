import 'package:get_it/get_it.dart';
import 'package:physiomarapp/repostory/user_auth_repostory.dart';
import 'package:physiomarapp/repostory/user_db_repostory.dart';
import 'package:physiomarapp/repostory/user_model_repostory.dart';
import 'package:physiomarapp/repostory/user_strorage_repostory.dart';
import 'package:physiomarapp/servisler/database_firestore_db_servis.dart';
import 'package:physiomarapp/servisler/safaksayar_demo_servis.dart';
import 'package:physiomarapp/servisler/safaksayar_release_servisi.dart';
import 'package:physiomarapp/servisler/storage_firebase_servis.dart';
import 'package:physiomarapp/servisler/user_auth_demo_servis.dart';
import 'package:physiomarapp/servisler/user_auth_relase_servis.dart';

GetIt locator = GetIt.instance;

void setupLocatorSafakSayar(){

  locator.registerLazySingleton(()=>UserModelSafakSayarRepo());

  //UserAuth Servislerim
  locator.registerLazySingleton(()=>SafakSayarDemoServisi());
  locator.registerLazySingleton(()=>SafakSayarReleaseServisi());

  //User Auth Locator
  locator.registerLazySingleton(()=>UserAuthReleaseServis());
  locator.registerLazySingleton(()=>UserAuthDemoServis());
  locator.registerLazySingleton(()=>UserAuthRepostory());

  //User DB Servis
  locator.registerLazySingleton(()=>FireStoreDbServis());
  locator.registerLazySingleton(()=>UserDbRepostory());

  //User FileStorage Servisi
  locator.registerLazySingleton(()=>FileStorageRepostory());
  locator.registerLazySingleton(()=>FileStorageFireBase());

}