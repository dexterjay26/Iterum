import 'package:FastAid/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../screens/home_screen.dart';
import '../providers/google_sign_in.dart';

class TakeSelfie extends StatefulWidget {
  final id;
  final name;
  final email;
  final number;
  final birthDate;
  final address;
  final String imgUrl;

  TakeSelfie({
    this.id,
    this.name,
    this.email,
    this.number,
    this.imgUrl,
    this.birthDate,
    this.address,
  });

  @override
  _TakeSelfieState createState() => _TakeSelfieState();
}

class _TakeSelfieState extends State<TakeSelfie> {
  File _storedImage;
  @override
  Widget build(BuildContext context) {
    void _pickImage({bool isCamera}) async {
      final _imagePicker = ImagePicker();
      final _imageFile = await _imagePicker.getImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150,
      );

      if (_imageFile == null) {
        return;
      }

      setState(() {
        _storedImage = File(_imageFile.path);
      });

      //widget.imagePicker(_storedImage);
    }

    void _signUp() {
      Provider.of<GoogleSignInProvider>(context, listen: false).createUser(
        id: widget.id,
        name: widget.name,
        email: widget.email,
        birthDate: widget.birthDate,
        address: widget.address,
        number: widget.number,
        imgUrl: widget.imgUrl,
      );
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
    }

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 150),
          child: Column(
            children: [
              CircleAvatar(
                radius: 85,
                backgroundImage: _storedImage == null
                    ? NetworkImage(
                        widget.imgUrl,
                      )
                    : FileImage(_storedImage),
              ),
              Spacer(),
              CustomButton(
                function: () => _pickImage(isCamera: true),
                text: "Take a Selfie",
                height: 45,
                width: 200,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                function: () => _pickImage(isCamera: false),
                text: "Select Image",
                height: 45,
                width: 200,
              ),
              Spacer(),
              Spacer(),
              CustomButton(
                function: _signUp,
                text: "Finish",
                height: 60,
                width: 220,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
