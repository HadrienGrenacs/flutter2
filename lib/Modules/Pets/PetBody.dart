import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Modules/Pets/PetDetails/ItemCard.dart';
import 'package:flutter2/Modules/Pets/PetDetails/petDetails.dart';
import 'package:flutter2/Modules/Pets/createPet.dart';
import 'package:flutter2/Theme/Theme.dart';

class PetBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference animals =
        FirebaseFirestore.instance.collection('animals');

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Animals'),
          backgroundColor: AppTheme.ZK_Azure,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreatePet()));
          },
          label: const Text('Add a pet'),
          icon: const Icon(Icons.plus_one),
          backgroundColor: Colors.green,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: animals.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("You don't have the Rights to do that");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: new GridView.count(
                crossAxisCount: 2,
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new ItemCard(
                      pet: document,
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PetDetails(
                                    pets: document,
                                  ))));
                }).toList(),
              ),
            );
          },
        ));
  }
}
