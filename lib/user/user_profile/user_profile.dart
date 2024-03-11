import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/user/user_main.dart';
import 'package:login/user/user_profile/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _ProfileSectionState createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<UserProfile> {
  File? _image;
  final _imageKey = 'selected_image';
  String _userName = 'User Name'; // Default user name

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString(_imageKey);
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  void _selectProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _saveImageToPrefs(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _saveImageToPrefs(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_imageKey, imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _selectProfileImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(Icons.add_a_photo, size: 50)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Text(
                          _userName,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildProfileItem(
              icon: Icons.person,
              label: 'View User Details',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserDetailsPage()),
                );
              },
            ),
            SizedBox(height: 20),
            _buildProfileItem(
              icon: Icons.notifications_outlined,
              label: 'Pause Notifications',
              onPressed: () {
                helo(context);
              },
            ),
            SizedBox(height: 20),
            _buildProfileItem(
              icon: Icons.settings,
              label: 'Preferences',
              onPressed: () {
                helo(context);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(60, 50), // Set minimum width to 120
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(icon),
            Text(label),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

void helo(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ScreenHome()),
  );
}
