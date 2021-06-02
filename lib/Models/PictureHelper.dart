import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PictureHelper {
  static firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static Future<bool> isEmptyPicture(String child, String path) async {
    return storage.ref().child(child).listAll().then((value) {
      bool empty = true;

      value.items.forEach((firebase_storage.Reference ref) {
        if (ref.fullPath == path) {
          empty = false;
        }
      });
      return empty;
    }).catchError((onError) {
      print(onError);
    });
  }

  static Future<String> getPictureURL(String path) async {
    return storage.ref().child(path).getDownloadURL().then((value) {
      if (value != null) {
        return value;
      } else {
        print('error value');
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  static Future<void> uploadFile(String path, String filePath) async {
    File file = File(filePath);

    return storage
        .ref()
        .child(path)
        .putFile(file)
        .then((value) => print("file uploaded"))
        .catchError((error) => print("Failed to upload file"));
  }
}
