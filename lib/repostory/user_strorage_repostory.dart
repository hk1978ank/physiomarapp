
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:physiomarapp/servisler/storage_base.dart';
import 'package:physiomarapp/servisler/storage_firebase_servis.dart';
import 'package:physiomarapp/view_model/locatorSafakSayar.dart';


enum CalismaModu {Relase,Demo }

class FileStorageRepostory with ChangeNotifier  implements FileStorageBase {
  CalismaModu calismaModu = CalismaModu.Relase;

  FileStorageFireBase _fileStorageFireBase = locator<FileStorageFireBase>();

  @override
  Future<String> uploadFile(String userID, String fileType, File file) async {

      if ( calismaModu == CalismaModu.Demo) {
        return null;
      }
      if ( calismaModu == CalismaModu.Relase) {
        var sonuc = await _fileStorageFireBase.uploadFile(userID, fileType, file);
        return sonuc;
      }
      return null;
    }

}