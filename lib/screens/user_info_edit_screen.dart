import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoEdit extends StatelessWidget {
  DocumentSnapshot userSnapshot;

  UserInfoEdit(this.userSnapshot);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  final birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = userSnapshot.data()['name'];
    numberController.text = userSnapshot.data()['number'];
    emailController.text = userSnapshot.data()['email'];
    addressController.text = userSnapshot.data()['address'];
    birthDateController.text = userSnapshot.data()['birthDate'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: birthDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
