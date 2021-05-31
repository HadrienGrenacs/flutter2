import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Modules/Planning/AddTaskForm.dart';
import 'package:flutter2/Theme/Theme.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter2/Modules/Planning/DatePicker.dart';

class MemberDetails extends StatelessWidget {
  final DocumentSnapshot member;

  const MemberDetails({Key key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppTheme.ZK_Azure,
          title: Text(member.data()['name'])),
      body: MemberBody(member: member),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTaskForm(
                        member: member,
                      )));
        },
        label: const Text('Add a task'),
        icon: const Icon(Icons.plus_one),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class MemberBody extends StatelessWidget {
  final DocumentSnapshot member;

  const MemberBody({Key key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: SizedBox(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: _displayLeading(member.data()['email']),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    member.data()['name'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(bottom: 2.0)),
                                  Text(
                                    member.data()['email'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'author',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    'publishDate - readDuration',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            )),
        DatePicker(member: member),
      ],
    );
  }

  Widget _displayLeading(email) {
    final gravatar = Gravatar(email);

    if (gravatar != null) {
      return Image.network(gravatar.imageUrl());
    } else {
      return Icon(Icons.people);
    }
  }
}
