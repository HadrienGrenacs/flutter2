import 'package:flutter/material.dart';
import 'package:flutter2/Models/Pet.dart';
import 'package:flutter2/Theme/Theme.dart';


class ItemCard extends StatelessWidget {
  final Pet pet;
  final Function press;
  
  const ItemCard({Key key, this.pet, this.press,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
          child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppTheme.ZK_Azure,
                  borderRadius: BorderRadius.circular(16)),
              child: Image.asset(pet.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              pet.name,
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
