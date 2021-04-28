import 'package:flutter/material.dart';
import 'package:flutter2/Models/Pet.dart';
import 'package:flutter2/Theme/Theme.dart';

class Body extends StatelessWidget {
  final Pet pet;

  const Body({Key key, this.pet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Image(image: AssetImage(pet.image)),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.4),
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: PetDetailsSpecific(
                    size: size,
                    pet: pet,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 400, 10, 0),
                  child: OwnerInfos(pet: pet),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class PetDetailsSpecific extends StatelessWidget {
  final Pet pet;
  const PetDetailsSpecific({
    Key key,
    @required this.size,
    this.pet,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.3),
      height: 160,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "${pet.name}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[

              Container(
                constraints: BoxConstraints.expand(width: 100, height: 20),
                child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(pet.species,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
                child: Text("${pet.age} years",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black)),
              )
            ],
          ),
          Row(children: <Widget>[
            IconButton(icon: Icon(Icons.location_on, color: AppTheme.ZK_Azure,), onPressed: null),
              Text("enclosure ${pet.enclosure}",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.7))),
          ],),
          Row(children: <Widget>[
            IconButton(icon: Icon(Icons.restaurant, color: AppTheme.ZK_Azure,), onPressed: null),
            Text("${pet.foodType}",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.7))),
          ],)
        ],
      ),
    );
  }
}




class OwnerInfos extends StatelessWidget {
  const OwnerInfos({
    Key key,
    @required this.pet,
  }) : super(key: key);

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
                                Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Text("Owner",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(pet.ownerName,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.normal),
          ),
        ),
        Text(pet.ownerPhoneNumber,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.normal),
        ),

      ],),
    );
  }
}