import 'package:flutter/material.dart';
import 'package:flutter2/Theme/Theme.dart';
import 'package:dropdownfield/dropdownfield.dart';

class CreatePet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppTheme.ZK_Azure,),
      body: BodyCreate(),
    );
  }
}
 // ignore: must_be_immutable
 class BodyCreate extends StatefulWidget {

  Map<String, dynamic> formData;

  BodyCreate() {
    formData = {
      'PetSex': '',
      'Race': '',
      'Food': '',
      'Grooming': '',
      'Customer': '',
      'Phone': '',
    };
  }

  @override
  _BodyCreateState createState() => _BodyCreateState();
}

class _BodyCreateState extends State<BodyCreate> {

  List<String> petSex = [
    'Male',
    'Female',
  ];

  List<String> petRaces = [
    'Dog',
    'Cat',
    'Kakapo',
    'Kangaroo',
  ];

  List<String> foodType = [
    'Dog Food',
    'Cat Food',
    'Grains',
    'Herb',
  ];

  List<String> grooming = [
    'Yes',
    'No',
  ];

  List<String> customer = [
    'Jessica Walmart',
    'Louis Lefun',
    'Antonio Meh ',
    'Marie Blachere',
    'Dany Boon',
    'Dany DeVito',
  ];

    List<String> phone = [
    '0645342314',
    '0645342678',
    '0645342670',
    '0645342871',
    '0655342871',
    '0655342871',
  ];

  @override
   Widget build(BuildContext context) {
     return Container(
      child: SingleChildScrollView(
              child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
          ))),
          DropDownField(
            value: widget.formData['PetSex'],
            required: true,
            hintText: 'Choose a sex',
            labelText: 'Sex',
            items: petSex,
            strict: false,
            setter: (dynamic newValue) {
            widget.formData['PetSex'] = newValue;
            }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
          ))),
          DropDownField(
            value: widget.formData['Race'],
            required: true,
            hintText: 'Choose a Race',
            labelText: 'Race',
            items: petRaces,
            strict: false,
            setter: (dynamic newValue) {
            widget.formData['Race'] = newValue;
            }),
          DropDownField(
            value: widget.formData['Food'],
            required: true,
            hintText: 'Choose a Food type',
            labelText: 'Food Type',
            items: foodType,
            strict: false,
            setter: (dynamic newValue) {
            widget.formData['Food'] = newValue;
            }),
          DropDownField(
            value: widget.formData['Grooming'],
            required: true,
            hintText: 'Add Grooming Option',
            labelText: 'Grooming',
            items: grooming,
            strict: false,
            setter: (dynamic newValue) {
            widget.formData['Grooming'] = newValue;
            }),
          DropDownField(
            value: widget.formData['Phone'],
            required: true,
            hintText: 'Choose a Phone Number',
            labelText: 'Phone Number',
            items: phone,
            strict: false,
            setter: (dynamic newValue) {
            widget.formData['Phone'] = newValue;
            }),
          Container(
            padding: EdgeInsets.all(5.0),
            width: (MediaQuery.of(context).size.width),
            height: 50,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppTheme.ZK_Gray),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppTheme.ZK_Olive),
                ),
                autofocus: false,
                onPressed: () => {},
                child: Text('Add a pet', style: TextStyle(fontSize: 20)))),
        ]),
      ),  
     );
   }
}