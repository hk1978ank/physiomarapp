
import 'dart:io';

abstract class FileStorageBase {
  Future<String> uploadFile(String userID, String fileType,File file);
}