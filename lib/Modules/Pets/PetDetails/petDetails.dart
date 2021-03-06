import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Models/Pet.dart';
import 'package:flutter2/Modules/Pets/PetDetails/Components/body.dart';
import 'package:flutter2/Theme/Theme.dart';

class PetDetails extends StatelessWidget {
  final DocumentSnapshot  pets;

  const PetDetails({Key key, this.pets}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
          child: Scaffold(
        backgroundColor: AppTheme.ZK_Azure,
        appBar: AppBar(backgroundColor: AppTheme.ZK_Azure,),
        body: Body(pet: pets),
      ),
    );
  }
}
