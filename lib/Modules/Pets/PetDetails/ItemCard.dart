import 'package:flutter/material.dart';
import 'package:flutter2/Models/Pet.dart';
import 'package:flutter2/Theme/Theme.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final Function press;

  const ItemCard({
    Key key,
    this.press, this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          /*
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppTheme.ZK_Azure,
                  borderRadius: BorderRadius.circular(16)),
              child: Image.asset(animal.image),
            ),
          ),
          */
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              name,
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
