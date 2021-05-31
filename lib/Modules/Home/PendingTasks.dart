import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter2/Modules/Planning/TaskCard.dart';
import 'package:flutter2/Modules/Home/PendingTaskDetails.dart';

class PendingTasks extends StatefulWidget {
  @override
  _PendingTasksState createState() => _PendingTasksState();
}

class _PendingTasksState extends State<PendingTasks> {
  Stream<QuerySnapshot> _tasks;

  @override
  Widget build(BuildContext context) {
    _tasks = FirebaseFirestore.instance
        .collection('tasks')
        .where('status', isEqualTo: 'pending')
        .snapshots();

    return Center(
      child: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: _tasks,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(
                    "You don't have the Rights to do that. ERROR: ${snapshot.error}");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
                return Container(
                  height: 120.0,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text('No pending tasks')),
                );
              }
              return Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: new ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return new TaskCard(
                          task: document,
                          press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PendingTaskDetails(
                                        task: document,
                                      ))));
                    }).toList(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
