import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Theme/Theme.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter2/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _email;
  String _name;
  String _password;
  bool _animate;

  @override
  void initState() {
    super.initState();

    _animate = true;

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      if (mounted) {
        setState(() {
          _animate = !_animate;
        });
      }
    });
  }

  Future<void> _createUser() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((user) {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(user.user.uid);
      userRef.set({'email': user.user.email, 'name': _name});
      List rightsList = [
        {'type': "USER_READ", 'id': "hR35ZILf9Rwt3wnDrrsh"},
        {'type': "TASKS_READ", 'id': "NlXL9KyWGL5vXTxx0rQd"},
        {'type': "TASKS_UPDATE", 'id': "tzLuwsi95t0yqnLj9M4F"},
        {'type': "ANIMALS_CREATE", 'id': "uwtIOVhR4gbF5wwyI2V4"},
        {'type': "ANIMALS_UPDATE", 'id': "z1TkyZi3OvhhsmeEICBB"},
        {'type': "ANIMALS_READ", 'id': "QBCAwvDeqSVKsSOp5tD5"},
        {'type': "USERS_ROLES_READ", 'id': "4XnFCLp5WADadFZCADNC"},
      ];
      rightsList.forEach((right) {
        print(right['id']);
        DocumentReference userRight = FirebaseFirestore.instance
            .collection("users_right")
            .doc(user.user.uid + "_" + right['id']);
        userRight.set({'right_id': right['id'], 'user_id': user.user.uid});
      });
      DocumentReference userRoles = FirebaseFirestore.instance
          .collection('users_roles')
          .doc(user.user.uid + "_" + "EPl2ABTEs2aoZzRth1MC");
      userRoles
          .set({'user_id': user.user.uid, 'role_id': "EPl2ABTEs2aoZzRth1MC"});
      DocumentReference usersGroups = FirebaseFirestore.instance
          .collection('users_groups')
          .doc(user.user.uid + "_" + "87uq48goyVrRtXZ1xbHl");
      usersGroups
          .set({'user_id': user.user.uid, 'group_id': "87uq48goyVrRtXZ1xbHl"});
    }).catchError((e) {
      throw Exception('$e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AppBar(backgroundColor: AppTheme.ZK_Azure, title: Text('Sign up')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: AnimatedContainer(
                    width: _animate
                        ? MediaQuery.of(context).size.height * 0.25
                        : MediaQuery.of(context).size.height * 0.20,
                    height: _animate
                        ? MediaQuery.of(context).size.height * 0.25
                        : MediaQuery.of(context).size.height * 0.20,
                    child: Image.asset('assets/images/zookeeper.png'),
                    duration: Duration(seconds: 2)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
                onChanged: (value) => setState(() => _email = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Name', border: OutlineInputBorder()),
                onChanged: (value) => setState(() => _name = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
                onChanged: (value) => setState(() => _password = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 26.0,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppTheme.ZK_Azure),
                  ),
                  onPressed: _createUser,
                  child: Text("Sign up"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppTheme.ZK_Olive),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text("Sign in"),
                ),
              ]),
            ],
          )),
    );
  }
}
