import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CameraPage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<CameraPage> {
  File? _image;
  final _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize FirebaseAuth

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Upload Image',
          ),
        ),
        backgroundColor: Color.fromARGB(255, 21, 24, 29),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: _image == null
                  ? Text(
                      'No image selected.',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : Image.file(_image!),
            ),
            ElevatedButton(
              onPressed: () async {
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                setState(() {
                  if (pickedFile != null) {
                    _image = File(pickedFile.path);
                  }
                });
              },
              child: Text('Select Image'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Check if user is authenticated
                if (_auth.currentUser == null) {
                  // If user is not authenticated, prompt them to log in
                  // You can handle authentication using Firebase Authentication
                  // For example, you can navigate to a login screen using Navigator
                  Navigator.pushNamed(context,
                      '/login'); // Replace '/login' with your login screen route
                  return;
                }

                if (_image != null) {
                  firebase_storage.Reference ref =
                      firebase_storage.FirebaseStorage.instance
                          .ref() // root directory
                          .child('Report') // subdirectory
                          .child('${DateTime.now()}.jpg'); // filename

                  await ref.putFile(_image!).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Image uploaded successfully'),
                        backgroundColor: Color.fromARGB(255, 21, 24, 29), // set background color here
                      ),
                    );
                  });

                  String downloadURL = await ref.getDownloadURL();

                  print('File uploaded to Firebase Storage: $downloadURL');
                }
              },
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
