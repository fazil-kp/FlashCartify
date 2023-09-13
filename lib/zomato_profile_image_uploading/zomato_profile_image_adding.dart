import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zomato_project/database/add_data.dart';
import 'package:zomato_project/zomato_profile_image_uploading/pick_image.dart';

class ZomatoProfileAdding extends StatefulWidget {
  const ZomatoProfileAdding({Key? key}) : super(key: key);

  @override
  State<ZomatoProfileAdding> createState() => _ZomatoProfileAddingState();
}

class _ZomatoProfileAddingState extends State<ZomatoProfileAdding> {
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  )
                      : CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        "https://www.pngitem.com/pimgs/m/137-1370051_avatar-generic-avatar-hd-png-download.png"),
                  ),
                  Positioned(
                    child: IconButton(
                      onPressed: selectImage,// Call the selectImage function when IconButton is pressed
                      icon: Icon(Icons.add_a_photo_outlined),
                    ),
                    bottom: -10,
                    left: 80,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
    String res = await StoreData().saveData(file: _image!);
  }

  saveProfile() async{

    String res = await StoreData().saveData(file: _image!);

  }
}
