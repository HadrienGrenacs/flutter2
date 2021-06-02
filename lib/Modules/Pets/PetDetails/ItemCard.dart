import 'package:flutter/material.dart';
import 'package:flutter2/Theme/Theme.dart';
import 'package:flutter2/Models/PictureHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemCard extends StatefulWidget {
  final DocumentSnapshot pet;
  final Function press;

  const ItemCard({
    Key key,
    this.press,
    this.pet,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
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
    return GestureDetector(
      onTap: widget.press,
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppTheme.ZK_Azure,
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                  image: downloadURL != null
                      ? NetworkImage(downloadURL)
                      : NetworkImage(
                          'https://img.icons8.com/ios-glyphs/452/pets.png'),
                  fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              widget.pet.data()['name'],
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
