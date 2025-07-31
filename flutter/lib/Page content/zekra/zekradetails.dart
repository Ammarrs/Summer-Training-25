//nada
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarteeb_app/customes/customtextfield.dart';

class Zekradetails extends StatefulWidget {
  const Zekradetails({super.key});
  
  @override
  State<Zekradetails> createState() => _ZekradetailsState();
}

class _ZekradetailsState extends State<Zekradetails> {
  final GlobalKey<FormState> formkey=GlobalKey();
  String? title;
  String? description;
  File? _image;

  Future<void> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); 
      });
    }
  }

  
  Future<void> pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth =MediaQuery.of(context).size.width;
    double screenhight =MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20 ,vertical:10 ),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    width: screenwidth/2,
                    height: screenhight/4,
                    child: _image != null
                      ? Image.file(_image!, width: 200, height: 200)
                      : Center(child: const Text('no image picked')),
                  ),
                  const SizedBox(height: 20),
          
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: pickImageFromGallery,
                        child: const Text('pick image from gallery'),
                      ),
                      ElevatedButton(
                      onPressed: pickImageFromCamera,
                      child: const Text('pick Image From Camera'),
                    ),],
                  ),
               
                  CustomTextField(
                    label: 'title',
                    keyboardType: TextInputType.text,
                    onsaved: (value){
                      title=value;
                    },  
                  ),
                  CustomTextField(
                    label: 'description',
                    keyboardType: TextInputType.text,
                    onsaved: (value){
                      description=value;
                    },  
                  ),
                  TextButton(onPressed: (){}, child: Text('save'))
                ],
              ),
            ),
          
          ),
        ),
      ),
    );
  }
}