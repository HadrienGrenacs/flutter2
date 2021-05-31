import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'Theme/Theme.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
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

  // Future<void> _createUser() async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: _email, password: _password);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print("error: $e");
  //   }
  // }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print("error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Future<void> addUser() {
    //   return users
    //       .add({'email': _email, 'name': "jhon", 'user': "manager"})
    //       .then((value) => print("User Added"))
    //       .catchError((error) => print("Failed to add user: $error"));
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: AppTheme.ZK_Azure, title: Text('Login')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                child: AnimatedContainer(
                    width: _animate ? 280.0 : 250.0,
                    height: _animate ? 280.0 : 250.0,
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppTheme.ZK_Azure),
                  ),
                  onPressed: _login,
                  child: Text("Sign in"),
                ),
              ]),
            ],
          )),
    );
  }
}
