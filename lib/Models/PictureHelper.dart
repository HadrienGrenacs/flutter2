import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PictureHelper {
  static firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static Future<bool> isPicture(id) async {
    return storage.ref().child('images/').listAll().then((value) {
      bool empty = true;

      value.items.forEach((firebase_storage.Reference ref) {
        if (ref.fullPath == 'images/' + id + '.png') {
          empty = false;
        }
      });
      return empty;
    }).catchError((onError) {
      print(onError);
    });
  }

  static Future<String> getPictureURL(id) async {
    return storage
        .ref()
        .child('images/' + id + '.png')
        .getDownloadURL()
        .then((value) {
      if (value != null) {
        return value;
      } else {
        print('error value');
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}
