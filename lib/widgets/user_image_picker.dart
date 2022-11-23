import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  XFile? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _pickedImage != null ? FileImage(File(_pickedImage!.path)) : null,
        ),
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.camera),
          label: const Text('Add Image'),
        ),
      ],
    );
  }

  _pickImage() async {
    /// create dialog with gallery and camera icon to let user choose which to open
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = pickedImage;
    });
  }

}
