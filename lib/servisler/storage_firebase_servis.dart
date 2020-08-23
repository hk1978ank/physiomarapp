import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:physiomarapp/servisler/storage_base.dart';

class FileStorageFireBase implements FileStorageBase{
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
   StorageReference _storageReferance;


  @override
  Future<String> uploadFile(String userID, String fileType, File file) async {
    _storageReferance = await _firebaseStorage.ref().child("profilfotolari").child(userID).child(fileType).child("profil_photo");
    var uploadTask = await _storageReferance.putFile(file);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return url;
  }
  
  
}