import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revfood/splashscreen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  File? _image;

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: Image(
                    height: 200,
                    width: 500,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/profil_background.jpg'),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 150),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromARGB(146, 0, 0, 0)),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: _image != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 50,
                            child: IconButton(
                              onPressed: _pickImage,
                              icon: Icon(Icons.add_photo_alternate),
                            ),
                          ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
