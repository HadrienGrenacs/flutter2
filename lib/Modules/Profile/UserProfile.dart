import 'package:flutter/material.dart';
import 'package:flutter2/Modules/Profile/Picture.dart';
import 'package:flutter2/Modules/Profile/Infos.dart';
import 'package:flutter2/Theme/Theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('User profile'), backgroundColor: AppTheme.ZK_Azure),
      body: Column(
        children: [
          Picture(
              child: 'images/',
              path: 'images/' + FirebaseAuth.instance.currentUser.uid + '.png'),
          SizedBox(
            height: 20.0,
          ),
          Infos()
        ],
      ),
    );
  }
}
