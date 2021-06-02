import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter2/Theme/Theme.dart';
import 'package:flutter2/Components/DropdownInput.dart';
import 'package:flutter2/Components/DateTimeField.dart';
import 'package:flutter2/Models/Pet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter2/Models/PictureHelper.dart';
import 'dart:io';

class CreatePet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.ZK_Azure,
      ),
      body: BodyCreate(),
    );
  }
}

// ignore: must_be_immutable
class BodyCreate extends StatefulWidget {
  BodyCreate() {}

  @override
  _BodyCreateState createState() => _BodyCreateState();
}

class _BodyCreateState extends State<BodyCreate> {
  String name;
  String race;
  String sex;
  String age;
  String food;
  String customer;
  String phone;
  DateTime starting;
  DateTime end;
  File _image;
  final picker = ImagePicker();
  List<String> petSex = [
    'Male',
    'Female',
  ];
  List<String> petRaces = ['Dog', 'Cat', 'Bird', 'Rodent', 'Other'];
  Color _color = AppTheme.ZK_Azure;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      if (mounted) {
        final random = Random();
        setState(() {
          _color = Color.fromRGBO(
            random.nextInt(256),
            random.nextInt(256),
            random.nextInt(256),
            1,
          );
        });
      }
    });
  }

  Future getPhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 2),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: _color,
                          offset: const Offset(
                            6.0,
                            6.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _image == null
                              ? NetworkImage(
                                  'https://img.icons8.com/ios-glyphs/452/pets.png')
                              : FileImage(_image),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Positioned(
                      top: 90,
                      right: 90,
                      child: MaterialButton(
                        onPressed: getImage,
                        color: AppTheme.ZK_Azure,
                        textColor: Colors.white,
                        child: Icon(
                          Icons.image,
                          size: 22,
                        ),
                        padding: EdgeInsets.all(14),
                        shape: CircleBorder(),
                      )),
                  Positioned(
                      top: 90,
                      left: 90,
                      child: MaterialButton(
                        onPressed: getPhoto,
                        color: AppTheme.ZK_Azure,
                        textColor: Colors.white,
                        child: Icon(
                          Icons.add_a_photo,
                          size: 22,
                        ),
                        padding: EdgeInsets.all(14),
                        shape: CircleBorder(),
                      ))
                ],
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildName(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppDropdownInput(
                  hintText: "Race",
                  options: petRaces,
                  value: race,
                  onChanged: (String value) {
                    setState(() {
                      race = value;
                    });
                  },
                  getLabel: (String value) => value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppDropdownInput(
                  hintText: "Sex",
                  options: petSex,
                  value: sex,
                  onChanged: (String value) {
                    setState(() {
                      sex = value;
                    });
                  },
                  getLabel: (String value) => value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildAge(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildFood(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildCustomer(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildPhone(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BasicDateTimeField(
                  hintText: "From",
                  value: starting,
                  onChanged: (DateTime value) {
                    setState(() {
                      starting = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BasicDateTimeField(
                  hintText: "To",
                  value: end,
                  onChanged: (DateTime value) {
                    setState(() {
                      end = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      PetHelper.addPet(name, race, sex, age, food, customer,
                              phone, starting, end)
                          .then((animal) {
                        if (_image != null) {
                          return PictureHelper.uploadFile(
                              animal.path + '.png', _image.path);
                        }
                      }).then((value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Pet added')));
                        Navigator.pop(context);
                      }).catchError(
                              (error) => throw Exception('Failed to add pet'));
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget buildName() => TextFormField(
        decoration:
            InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
        onChanged: (value) => setState(() => name = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      );

  Widget buildAge() => TextFormField(
        keyboardType: TextInputType.number,
        decoration:
            InputDecoration(labelText: 'Age', border: OutlineInputBorder()),
        onChanged: (value) => setState(() => age = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      );
  Widget buildFood() => TextFormField(
        decoration:
            InputDecoration(labelText: 'Food', border: OutlineInputBorder()),
        onChanged: (value) => setState(() => food = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      );

  Widget buildCustomer() => TextFormField(
        decoration: InputDecoration(
            labelText: 'Customer', border: OutlineInputBorder()),
        onChanged: (value) => setState(() => customer = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      );

  Widget buildPhone() => TextFormField(
        keyboardType: TextInputType.phone,
        inputFormatters: [
          new LengthLimitingTextInputFormatter(10),
          new FilteringTextInputFormatter.allow(new RegExp(r'^[0-9]*$')),
        ],
        decoration: InputDecoration(
            labelText: 'Phone number', border: OutlineInputBorder()),
        onChanged: (value) => setState(() => phone = value),
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              !RegExp(r'^[0-9]*$').hasMatch(value)) {
            return 'Please enter valid phone number';
          }
          return null;
        },
      );
}
