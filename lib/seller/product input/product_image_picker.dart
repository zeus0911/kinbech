import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductImagePicker extends StatefulWidget {
  final void Function(File? image) onImageSelected;

  const AddProductImagePicker({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  _AddProductImagePickerState createState() => _AddProductImagePickerState();
}

class _AddProductImagePickerState extends State<AddProductImagePicker> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Product Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: () async {
                final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    _image = File(image.path);
                  });
                  widget.onImageSelected(_image);
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
    );
  }
}
