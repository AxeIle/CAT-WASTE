import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  // Use a GlobalKey to provide a unique identifier for the DropdownButtonFormField

  UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to Our App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Instructions: Add instructions about the app here.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Credit System: Describe the credit system here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
