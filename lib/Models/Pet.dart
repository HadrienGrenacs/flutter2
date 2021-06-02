import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AnimalInformations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference animals =
        FirebaseFirestore.instance.collection('animals');

    return StreamBuilder<QuerySnapshot>(
      stream: animals.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['name']),
              subtitle: new Text(document.data()['food']),
            );
          }).toList(),
        );
      },
    );
  }
}

class PetHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<DocumentReference> addPet(
      name, race, sex, age, food, customer, phone, starting, end) {
    return _db.collection('animals').add({
      'enclosure': new Random().nextInt(100) + 1,
      'name': name,
      'race': race,
      'sex': sex,
      'age': age,
      'food': food,
      'food quantity': new Random().nextInt(100) + 10,
      'customer': customer,
      'phone': phone,
      'entry': starting,
      'exit': end,
      'status': 'pending',
    }).then((value) {
      print("pet created");
      return (value);
    }).catchError((error) => throw Exception('Failed to add pet'));
  }

  static Future<void> removePet(id) {
    return _db.collection('animals').doc(id).delete().then((value) {
      print("pet deleted");
    }).catchError((error) => throw Exception('Failed to delete pet'));
  }
}

class Pet {
  List<String> documentIds = [];

  List<String> GetAnmailDocIds() {
    FirebaseFirestore.instance
        .collection('animals')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        documentIds.add(doc.id);
      });
    });
    return documentIds;
  }
}
