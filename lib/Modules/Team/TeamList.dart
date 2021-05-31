import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter2/Modules/Team/MemberCard.dart';
import 'package:flutter2/Modules/Team/MemberDetails.dart';

class TeamList extends StatefulWidget {
  @override
  _TeamListState createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        if (!snapshot.hasData) {
          return Align(
              alignment: Alignment.center, child: Text('Nothing to display'));
        }
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new MemberCard(
                member: document,
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MemberDetails(
                              member: document,
                            ))));
          }).toList(),
        );
      },
    );
  }
}
