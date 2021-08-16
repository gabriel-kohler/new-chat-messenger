import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) onImagePick;

  UserImagePicker(this.onImagePick);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      //imageQuality: 50,
      //maxWidth: 150,
    );

    _pickedImageFile = File(pickedImage.path);

    widget.onImagePick(_pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey[200],
          backgroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          label: Text('Adicionar imagem'),
          icon: Icon(Icons.image),
        ),
      ],
    );
  }
}
