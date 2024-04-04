import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kinbech/seller/homepage%20icons/home.dart';
import 'package:kinbech/seller/product%20input/user_location.dart';
import 'package:kinbech/services/photo.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../homepage icons/orders.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class User {
  final String name;
  final int id;

  User({required this.name, required this.id});

  @override
  String toString() {
    return 'User(name: $name, id: $id)';
  }
}

class _AddProductScreenState extends State<AddProductScreen> {
  final MultiSelectController<User> _controller = MultiSelectController();
  final List<ValueItem> _selectedOptions = [];
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var descController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  File? _image;
  UserPhoto userPhoto = UserPhoto();
  LocationModel? selectedLocation;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Product',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.green,
          elevation: 0, // Remove appbar elevation
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: _image == null
                                  ? Text('No image selected.')
                                  : Image.file(_image!),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                            ),
                            onPressed: () async {
                              final image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  _image = File(image.path);
                                });
                              }
                            },
                            child: const Text(
                              'Select image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: titleController,
                    maxLength: 30, // Limit title length
                    decoration: InputDecoration(
                      labelText: 'Title (max 30 characters)',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: descController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: priceController,
                    maxLength: 20,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Features',
                    textAlign: TextAlign.left,
                  ),
                  MultiSelectDropDown<User>(
                    controller: _controller,
                    clearIcon: const Icon(Icons.car_rental),
                    onOptionSelected: (options) {
                      _selectedOptions.clear();
                      _selectedOptions.addAll(options);
                    },
                    options: <ValueItem<User>>[
                      ValueItem(
                          label: 'Closed Roof',
                          value: User(name: 'User 1', id: 1)),
                      ValueItem(
                          label: 'Surveillance',
                          value: User(name: 'User 2', id: 2)),
                      ValueItem(
                          label: 'Gated Parking',
                          value: User(name: 'User 3', id: 3)),
                      ValueItem(
                          label: 'EV Charging',
                          value: User(name: 'User 4', id: 4)),
                    ],
                    maxItems: 4,
                    singleSelectItemStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    chipConfig: const ChipConfig(
                        wrapType: WrapType.wrap, backgroundColor: Colors.green),
                    optionTextStyle: const TextStyle(fontSize: 16),
                    selectedOptionIcon: const Icon(
                      Icons.check_circle,
                      color: Colors.pink,
                    ),
                    selectedOptionBackgroundColor: Colors.grey.shade300,
                    selectedOptionTextColor: Colors.blue,
                    dropdownMargin: 2,
                    onOptionRemoved: (index, option) {},
                    optionBuilder: (context, valueItem, isSelected) {
                      return ListTile(
                        title: Text(valueItem.label),
                        subtitle: Text(valueItem.value.toString()),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle)
                            : const Icon(Icons.radio_button_unchecked),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () async {
                      final location = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MapPage(),
                        ),
                      );
                      if (location != null && location is LocationModel) {
                        setState(() {
                          selectedLocation =
                              location; // Update selected location
                        });
                      }
                    },
                    child: Text(
                      "Select your Location",
                      style: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                  ),
                  if (selectedLocation != null)
                    Text(
                        "Selected Location: ${selectedLocation!.latitude}, ${selectedLocation!.longitude}"),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      _showConfirmationDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Container(
                      width: size.width * 0.8,
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "Submit Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _resetFields() {
    titleController.clear();
    descController.clear();
    priceController.clear();
    _selectedOptions.clear();
    setState(() {
      _image = null;
      selectedLocation = null; // Clear selected location
    });
  }

  void _navigateToManageOrderScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            ManageOrdersScreen(), // Navigate to ManageOrderScreen
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to submit the product details?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _submitProductDetails(); // Submit the product details
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  void _submitProductDetails() async {
    if (titleController.text.isNotEmpty &&
        descController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        _image != null &&
        _selectedOptions.isNotEmpty &&
        selectedLocation != null) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Upload image file to Firebase Storage
          final imageName = DateTime.now().millisecondsSinceEpoch.toString();
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('driver_images/$imageName.jpg');
          final uploadTask = storageRef.putFile(_image!);
          final TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() {});
          final downloadUrl = await taskSnapshot.ref.getDownloadURL();

          // Store product details in Firestore with image URL
          await FirebaseFirestore.instance.collection("Products").add({
            "Title": titleController.text,
            "Description": descController.text,
            "Price": priceController.text,
            "Image": downloadUrl,
            "Features": _selectedOptions.map((option) => option.label).toList(),
            "Latitude": selectedLocation!.latitude, // Store latitude
            "Longitude": selectedLocation!.longitude, // Store longitude
            "userId": user.uid, // Store user's UID
          });

          // Reset fields after successful submission
          _resetFields();

          // Navigate to ManageOrderScreen after successful submission
          _navigateToManageOrderScreen();
        } else {
          // Handle case where user is null (should not happen in a logged-in state)
        }
      } catch (error) {
        print("Error submitting product: $error");
        // Handle error if needed
      }
    }
  }
}
