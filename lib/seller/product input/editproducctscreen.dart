import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  final String _image;
  late String _title;
  late String _description;
  late String _price;
  late List<String> _features;
  late double _latitude;
  late double _longitude;

  @override
  void initState() {
    super.initState();
    _loadProductDetails();
  }

  Future<void> _loadProductDetails() async {
    try {
      // Fetch product details from Firestore
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance.collection('Products').doc().get();
      Map<String, dynamic> data = productSnapshot.data() as Map<String, dynamic>;

      setState(() {
        _image = data['image'];
        _title = data['title'];
        _description = data['description'];
        _price = data['price'];
        _features = List<String>.from(data['features']);
        _latitude = data['latitude'];
        _longitude = data['longitude'];

        // Set initial values to text controllers
        _titleController.text = _title;
        _descriptionController.text = _description;
        _priceController.text = _price;
      });
    } catch (error) {
      print('Error loading product details: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              onChanged: (value) => _title = value,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              onChanged: (value) => _description = value,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              onChanged: (value) => _price = value,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Change Image'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _editFeatures,
              child: Text('Edit Features'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile.path;
      });
    }
  }

  void _editFeatures() async {
    // Implement feature editing logic here
    // For example, navigate to a new screen to edit features
    // and update _features accordingly
  }

  Future<void> _saveChanges() async {
    try {
      // Update product details in Firestore
      await FirebaseFirestore.instance.collection('Products').doc().update({
        'image': _image,
        'title': _title,
        'description': _description,
        'price': _price,
        'features': _features,
        'latitude': _latitude,
        'longitude': _longitude,
      });

      // Navigate back to the previous screen with result
      Navigator.pop(context, true);
    } catch (error) {
      print('Error saving changes: $error');
      // Handle error as needed
      // Show error message, retry option, etc.
    }
  }
}
