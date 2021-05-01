import 'package:flutter/material.dart';
import 'package:flutter2/Models/Pet.dart';
import 'package:flutter2/Modules/Pets/PetDetails/ItemCard.dart';
import 'package:flutter2/Modules/Pets/PetDetails/petDetails.dart';
import 'package:flutter2/Modules/Pets/createPet.dart';
import 'package:flutter2/Theme/Theme.dart';

class PetBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
              itemCount: pets.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.75),
              itemBuilder: (context, index) => ItemCard(
                  pet: pets[index],
                  press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PetDetails(
                                pets: pets[index],
                              ))))),
        )),
        Container(
            padding: EdgeInsets.all(5.0),
            width: (MediaQuery.of(context).size.width),
            height: 50,
            child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppTheme.ZK_Gray),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppTheme.ZK_Olive),
                ),
                autofocus: false,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreatePet())),
                icon: Icon(Icons.add_circle_rounded, size: 40),
                label: Text('Add a pet', style: TextStyle(fontSize: 20)))),
      ],
    );
  }
}
