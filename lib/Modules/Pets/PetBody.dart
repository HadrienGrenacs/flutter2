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
/*
class PetBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
              width: 1000,
              child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
                itemCount: pets.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.75),
                itemBuilder: (context, index) => ItemCard(
                    pet: pets[index],
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PetDetails(
                                  pets: pets[index],
          ))))),
        ),
            )),
        Container(
            padding: EdgeInsets.all(5.0),
            width: (MediaQuery.of(context).size.width),
            height: 50,
            child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppTheme.ZK_Gray),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppTheme.ZK_Olive),
                ),
                autofocus: false,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreatePet())),
                icon: Icon(Icons.add_circle_rounded, size: 40),
                label: Text('Add a pet', style: TextStyle(fontSize: 20)))),
      ],
    );
  }
}
*/
