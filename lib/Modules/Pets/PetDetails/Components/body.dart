import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Theme/Theme.dart';
import 'package:flutter2/Models/PictureHelper.dart';
import 'package:intl/intl.dart';
import 'package:flutter2/Models/Pet.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  final DocumentSnapshot pet;

  const Body({Key key, this.pet}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String downloadURL;

  @override
  void initState() {
    super.initState();
    PictureHelper.isEmptyPicture(
            'animals/', 'animals/' + widget.pet.id + '.png')
        .then((value) {
      if (value) {
        return 'https://img.icons8.com/ios-glyphs/452/pets.png';
      } else {
        return PictureHelper.getPictureURL('animals/' + widget.pet.id + '.png')
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: 500,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Image(
                      image: downloadURL != null
                          ? NetworkImage(downloadURL)
                          : NetworkImage(
                              'https://img.icons8.com/ios-glyphs/452/pets.png')),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.4),
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: PetDetailsSpecific(
                      size: size,
                      pet: widget.pet,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 500, 10, 0),
                    child: OwnerInfos(pet: widget.pet),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PetDetailsSpecific extends StatelessWidget {
  final DocumentSnapshot pet;
  final Size size;
  const PetDetailsSpecific({
    Key key,
    @required this.size,
    this.pet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.3),
      height: 160,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "${pet.data()['name']}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                constraints: BoxConstraints.expand(width: 100, height: 20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(pet.data()['race'],
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
                child: Text("${pet.data()['age']} years",
                    style: TextStyle(fontSize: 15, color: Colors.black)),
              )
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.location_on,
                    color: AppTheme.ZK_Azure,
                  ),
                  onPressed: null),
              Text("enclosure ${pet.data()['enclosure']}",
                  style: TextStyle(
                      fontSize: 15, color: Colors.black.withOpacity(0.7))),
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.restaurant,
                    color: AppTheme.ZK_Azure,
                  ),
                  onPressed: null),
              Text("${pet.data()['food']}",
                  style: TextStyle(
                      fontSize: 15, color: Colors.black.withOpacity(0.7))),
            ],
          )
        ],
      ),
    );
  }
}

class OwnerInfos extends StatelessWidget {
  const OwnerInfos({
    Key key,
    @required this.pet,
  }) : super(key: key);

  final DocumentSnapshot pet;

  @override
  Widget build(BuildContext context) {
    bool _visible =
        FirebaseAuth.instance.currentUser.uid == '9DGI8yGwHYY6egC7h3MVIUTTwim1'
            ? true
            : false;

    return Container(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(children: <Widget>[
            Text(
              "From: " +
                  "${DateFormat.yMd().add_jm().format(pet.data()['entry'].toDate())}",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.normal),
            ),
            Text(
              "To: " +
                  "${DateFormat.yMd().add_jm().format(pet.data()['exit'].toDate())}",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.normal),
            )
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "Owner : ${pet.data()['customer']} / ${pet.data()['phone']}",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
              padding: EdgeInsets.all(5.0),
              width: (MediaQuery.of(context).size.width),
              height: 50,
              child: Visibility(
                visible: _visible,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppTheme.ZK_Gray),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(AppTheme.ZK_Olive),
                    ),
                    autofocus: false,
                    onPressed: () => {
                          PetHelper.removePet(pet.id).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Pet deleted')));
                            // Navigator.pop(context);
                          }).catchError((error) =>
                              throw Exception('Failed to delete pet'))
                        },
                    child: Text('Delete Pet', style: TextStyle(fontSize: 20))),
              )),
        ],
      ),
    );
  }
}
