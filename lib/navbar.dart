import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter2/Modules/Planning/DatePicker.dart';
import 'Modules/Pets/petBody.dart';
import 'Theme/Theme.dart';
import 'Modules/home.dart';

/// This is the stateful widget that the main application instantiates.
class HomePage extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<HomePage> {
  int _selectedIndex = 1;
  static List<Widget> _widgetOptions = <Widget>[
    DatePicker(),
    Home(),
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        //colors
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
