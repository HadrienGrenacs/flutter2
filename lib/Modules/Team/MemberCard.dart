import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';

class MemberCard extends StatelessWidget {
  final DocumentSnapshot member;
  final Function press;

  const MemberCard({
    Key key,
    this.member,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: ListTile(
          title: Text(member.data()['name']),
          subtitle: Text(member.data()['email']),
          leading: _displayLeading(member.data()['email']),
          trailing: Icon(Icons.chevron_right),
        ));
  }

  Widget _displayLeading(email) {
    final gravatar = Gravatar(email);

    if (gravatar != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(gravatar.imageUrl()),
      );
    } else {
      return Icon(Icons.people);
    }
  }
}
