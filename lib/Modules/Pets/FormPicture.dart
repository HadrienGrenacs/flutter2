import 'package:flutter2/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter2/Models/PictureHelper.dart';

class Picture extends StatefulWidget {
  final String child;
  final String path;

  const Picture({
    Key key,
    this.child,
    this.path,
  }) : super(key: key);

  @override
  _PictureState createState() => _PictureState();
}

class _PictureState extends State<Picture> {
  String downloadURL;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    PictureHelper.isEmptyPicture(widget.child, widget.path).then((value) {
      if (value) {
        return 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png';
      } else {
        return PictureHelper.getPictureURL(widget.path).then((value) {
          return value;
        });
      }
    }).then((value) {
      setState(() {
        downloadURL = value;
      });
    });
  }

  Future<void> upload(String filePath) async {
    PictureHelper.uploadFile(widget.path, filePath).then((value) {
      PictureHelper.getPictureURL(widget.path).then((value) {
        setState(() {
          downloadURL = value;
        });
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Image updated')));
    });
  }

  Future getPhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      upload(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      upload(pickedFile.path);
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
