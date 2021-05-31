import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Theme/Theme.dart';
import 'package:flutter2/Modules/Home/PendingTasks.dart';
import 'package:flutter2/Modules/Profile/UserProfile.dart';

class Home extends StatefulWidget {
  final String role;

  const Home({Key key, this.role}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 16,
      ),
      Row(
        children: [
          Align(
            alignment: Alignment(-0.90, 0.40),
            child: Text('👋 Hello ${widget.role}',
                style: TextStyle(fontSize: 20, color: AppTheme.ZK_Olive)),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Container(
            padding: EdgeInsets.all(5.0),
            width: (MediaQuery.of(context).size.width) / 2,
            height: 120,
            child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppTheme.ZK_Gray),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppTheme.ZK_Olive),
                ),
                autofocus: false,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
                icon: Icon(
                  Icons.person,
                  size: 40,
                ),
                label: Text('Profile', style: TextStyle(fontSize: 20)))),
        Container(
            padding: EdgeInsets.all(5.0),
            width: (MediaQuery.of(context).size.width) / 2,
            height: 120,
            child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppTheme.ZK_Gray),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppTheme.ZK_Olive),
                ),
                autofocus: false,
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle_rounded,
                  size: 40,
                ),
                label: Text('Add a pet', style: TextStyle(fontSize: 20))))
      ]),
      widget.role == 'user'
          ? SizedBox(
              height: 0,
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment(-0.90, 0.40),
                    child: Text('Pending tasks',
                        style:
                            TextStyle(fontSize: 25, color: AppTheme.ZK_Olive)),
                  ),
                  PendingTasks()
                ],
              )),
    ]);
  }
}
