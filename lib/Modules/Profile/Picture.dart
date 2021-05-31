import 'dart:io';

import 'package:flutter2/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';

class Picture extends StatefulWidget {
  @override
  _PictureState createState() => _PictureState();
}

class _PictureState extends State<Picture> {
  File _image;
  final picker = ImagePicker();

  Future<String> downloadUserImage(String id) async {
    print(id);
    String downloadURL = "";
    firebase_storage.FirebaseStorage.instance
        .ref('images/' + id + '.png')
        .getDownloadURL()
        .then((value) {
      downloadURL = value;
    }).catchError((onError) {
      downloadURL =
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png';
    });
    return downloadURL;

    //   try {
    //     downloadURL = await firebase_storage.FirebaseStorage.instance
    //         .ref('images/' + id + '.png')
    //         .getDownloadURL();
    //     if (downloadURL == null) {
    //       return ('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png');
    //     }
    //     debugPrint(downloadURL);
    //     return downloadURL;
    //   } catch (onError) {
    //     return ('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png');
    //   }
    // }
  }

  Future<void> uploadFile(String id, String path) async {
    File file = File(path);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('images/' + id + '.png')
          .putFile(file);
    } catch (e) {
      print(e);
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    if (pickedFile != null) {
      uploadFile(FirebaseAuth.instance.currentUser.uid, pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: downloadUserImage(FirebaseAuth.instance.currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(snapshot.data), fit: BoxFit.fill),
                    ),
                  ),
                  Positioned(
                      top: 90,
                      left: 90,
                      child: MaterialButton(
                        onPressed: getImage,
                        color: AppTheme.ZK_Azure,
                        textColor: Colors.white,
                        child: Icon(
                          Icons.add_a_photo,
                          size: 22,
                        ),
                        padding: EdgeInsets.all(14),
                        shape: CircleBorder(),
                      ))
                ],
              ),
            ),
          );
        });

    // Scaffold(
    //   body: Center(
    //     child: _image == null ? Text('No image selected.') : Image.file(_image),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: getImage,
    //     tooltip: 'Pick Image',
    //     child: Icon(Icons.add_a_photo),
    //   ),
    // );
  }
}
