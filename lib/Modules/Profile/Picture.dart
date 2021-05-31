import 'dart:io';

import 'package:flutter2/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter2/Models/PictureHelper.dart';

class Picture extends StatefulWidget {
  @override
  _PictureState createState() => _PictureState();
}

class _PictureState extends State<Picture> {
  String downloadURL;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    PictureHelper.isPicture(FirebaseAuth.instance.currentUser.uid)
        .then((value) {
      if (value) {
        return 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png';
      } else {
        return PictureHelper.getPictureURL(
                FirebaseAuth.instance.currentUser.uid)
            .then((value) {
          return value;
        });
      }
    }).then((value) {
      setState(() {
        downloadURL = value;
      });
    });
  }

  // initializeData() async {
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('images/')
  //       .listAll()
  //       .then((value) {
  //     print(value.items.length);
  //     bool empty = true;

  //     value.items.forEach((firebase_storage.Reference ref) {
  //       if (ref.fullPath ==
  //           'images/' + FirebaseAuth.instance.currentUser.uid + '.png') {
  //         empty = false;
  //       }
  //     });

  //     setState(() {
  //       if (empty || value.items.isEmpty) {
  //         downloadURL =
  //             'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png';
  //       } else {
  //         getData();
  //       }
  //     });
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  // }

  // getData() async {
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('images/' + FirebaseAuth.instance.currentUser.uid + '.png')
  //       .getDownloadURL()
  //       .then((value) {
  //     setState(() {
  //       if (value != null) {
  //         downloadURL = value;
  //       } else {
  //         print('error value');
  //       }
  //     });
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  // }

  Future<void> uploadFile(String id, String path) async {
    File file = File(path);

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/' + id + '.png')
        .putFile(file)
        .then((value) {
      PictureHelper.getPictureURL(FirebaseAuth.instance.currentUser.uid)
          .then((value) {
        setState(() {
          downloadURL = value;
        });
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Image profile updated')));
    });
  }

  Future getPhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      uploadFile(FirebaseAuth.instance.currentUser.uid, pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      uploadFile(FirebaseAuth.instance.currentUser.uid, pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    image: downloadURL != null
                        ? NetworkImage(downloadURL)
                        : NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Positioned(
                top: 90,
                right: 90,
                child: MaterialButton(
                  onPressed: getImage,
                  color: AppTheme.ZK_Azure,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.image,
                    size: 22,
                  ),
                  padding: EdgeInsets.all(14),
                  shape: CircleBorder(),
                )),
            Positioned(
                top: 90,
                left: 90,
                child: MaterialButton(
                  onPressed: getPhoto,
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
  }
}
