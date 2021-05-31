import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter2/Modules/Planning/Planning.dart';
import 'package:flutter2/Modules/Team/Team.dart';
import 'Modules/Pets/petBody.dart';
import 'Theme/Theme.dart';
import 'Modules/home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  int fiak = 1;

  static List<Widget> _widgetOptions = <Widget>[
    Planning(),
    Home(role: 'user'),
    PetBody()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        color: AppTheme.ZK_Azure,
        backgroundColor: Colors.white,
        height: 50,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        animationCurve: Curves.ease,
        items: <Widget>[
          Icon(Icons.date_range_rounded, size: 20, color: Colors.white),
          Icon(Icons.home_rounded, size: 20, color: Colors.white),
          Icon(Icons.pets_rounded, size: 20, color: Colors.white)
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

class ManagerHomePage extends StatefulWidget {
  @override
  _ManagerHomePageState createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  int _selectedIndex = 1;
  int fiak = 1;

  static List<Widget> _widgetOptions = <Widget>[
    Team(),
    Home(role: 'manager'),
    PetBody()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        color: AppTheme.ZK_Azure,
        backgroundColor: Colors.white,
        height: 50,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        animationCurve: Curves.ease,
        items: <Widget>[
          Icon(Icons.people, size: 20, color: Colors.white),
          Icon(Icons.home_rounded, size: 20, color: Colors.white),
          Icon(Icons.pets_rounded, size: 20, color: Colors.white)
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
