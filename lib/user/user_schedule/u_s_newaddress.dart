import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewAddressForm extends StatelessWidget {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();

  NewAddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: pinCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Pin Code'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: landmarkController,
              decoration: InputDecoration(labelText: 'Landmark'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Upload data to Firebase (similar to previous code)
                _uploadData(context);
                Navigator.pop(context); // Close the current screen
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadData(BuildContext context) async {
    // Get values from controllers
    String address = addressController.text;
    String pincode = pinCodeController.text;
    String landmark = landmarkController.text;
    BuildContext localContext = context;
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the reference to the 'users_db' collection
      CollectionReference usersCollection = firestore.collection('user');
      //DocumentReference usersDocument =
      //irestore.collection('users').doc('/users/users_address_db');
      // Add data to Firestore collection using add method
      await usersCollection.add({
        'landmark': landmark,
        'pincode': pincode,
        'address': address
      }).then((value) {
        // Display success message
        ScaffoldMessenger.of(localContext).showSnackBar(SnackBar(
          content: Text('Data uploaded successfully!'),
        ));
      });
    } on Exception catch (error) {
      // Display error message
      ScaffoldMessenger.of(localContext).showSnackBar(SnackBar(
        content: Text('Error uploading data: $error'),
      ));
      print(error);
    }
  }
}
