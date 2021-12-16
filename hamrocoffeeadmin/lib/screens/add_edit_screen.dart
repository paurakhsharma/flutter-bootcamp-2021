import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hamrocoffeeadmin/models/coffee.dart';

class AddEditScreen extends StatefulWidget {
  final Coffee? coffee;
  const AddEditScreen({Key? key, this.coffee}) : super(key: key);

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final shortPriceController = TextEditingController();
  final tallPriceController = TextEditingController();
  final grandePriceController = TextEditingController();
  final ventiPriceController = TextEditingController();

  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.coffee == null ? Text('Add Coffee') : Text('Edit Coffee'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text('Name'),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text('Description'),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  if (_image == null && widget.coffee != null)
                    Image.network(
                      widget.coffee!.imageUrl,
                    )
                  else if (_image != null)
                    Image.file(_image!),
                  SizedBox(height: 16),
                  IconButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        _image = File(result.files.single.path!);
                        setState(() {});
                      } else {
                        // User canceled the picker
                      }
                    },
                    iconSize: 64,
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Sizes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizeField(
                          label: 'Short',
                          controller: shortPriceController,
                        ),
                        const SizedBox(height: 5),
                        SizeField(
                          label: 'Tall',
                          controller: tallPriceController,
                        ),
                        const SizedBox(height: 5),
                        SizeField(
                          label: 'Grande',
                          controller: grandePriceController,
                        ),
                        const SizedBox(height: 5),
                        SizeField(
                          label: 'Venti',
                          controller: ventiPriceController,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        final coffeesRef =
                            FirebaseFirestore.instance.collection('coffees');

                        if (widget.coffee != null) {
                          // edit coffee
                          final name = nameController.text;
                          final description = descriptionController.text;

                          if (_image == null) {
                            // image not changed only update
                            // name and description
                            coffeesRef.doc(widget.coffee!.id).update({
                              "name": name,
                              "description": description,
                              "sizes": [
                                {
                                  "name": "Short",
                                  "price": int.parse(shortPriceController.text),
                                },
                                {
                                  "name": "Tall",
                                  "price": int.parse(tallPriceController.text),
                                },
                                {
                                  "name": "Grande",
                                  "price":
                                      int.parse(grandePriceController.text),
                                },
                                {
                                  "name": "Venti",
                                  "price": int.parse(ventiPriceController.text),
                                },
                              ],
                            });
                          } else {
                            // update image too
                            final imageUrl = await uploadImage(_image!, name);

                            coffeesRef.doc(widget.coffee!.id).update({
                              "name": name,
                              "description": description,
                              "imageUrl": imageUrl,
                              "sizes": [
                                {
                                  "name": "Short",
                                  "price": int.parse(shortPriceController.text),
                                },
                                {
                                  "name": "Tall",
                                  "price": int.parse(tallPriceController.text),
                                },
                                {
                                  "name": "Grande",
                                  "price":
                                      int.parse(grandePriceController.text),
                                },
                                {
                                  "name": "Venti",
                                  "price": int.parse(ventiPriceController.text),
                                },
                              ],
                            });
                          }
                        } else {
                          // add coffee
                          final name = nameController.text;
                          final description = descriptionController.text;

                          final imageUrl = await uploadImage(_image!, name);

                          coffeesRef.add({
                            'name': name,
                            'description': description,
                            'imageUrl': imageUrl,
                            "sizes": [
                              {
                                "name": "Short",
                                "price": int.parse(shortPriceController.text),
                              },
                              {
                                "name": "Tall",
                                "price": int.parse(tallPriceController.text),
                              },
                              {
                                "name": "Grande",
                                "price": int.parse(grandePriceController.text),
                              },
                              {
                                "name": "Venti",
                                "price": int.parse(ventiPriceController.text),
                              },
                            ],
                          });
                        }

                        Navigator.pop(context);
                      },
                      child: widget.coffee == null
                          ? Text('Add Coffee')
                          : Text('Edit Coffee'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> uploadImage(File image, String name) async {
    final extension = _image!.path.split('.').last;

    final task =
        await FirebaseStorage.instance.ref('$name.$extension').putFile(_image!);

    return await task.ref.getDownloadURL();
  }

  @override
  void initState() {
    if (widget.coffee != null) {
      nameController.text = widget.coffee!.name;
      descriptionController.text = widget.coffee!.description;
      shortPriceController.text = widget.coffee!.sizes[0].price.toString();
      tallPriceController.text = widget.coffee!.sizes[1].price.toString();
      grandePriceController.text = widget.coffee!.sizes[2].price.toString();
      ventiPriceController.text = widget.coffee!.sizes[3].price.toString();
    }
    super.initState();
  }
}

class SizeField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const SizeField({required this.label, required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        Spacer(),
        SizedBox(
          width: 200,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              label: Text('Price'),
              fillColor: Colors.white,
              filled: true,
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
