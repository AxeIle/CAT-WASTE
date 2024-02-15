import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/resueable/reuseable_widget.dart';

class NewAddressForm extends StatefulWidget {
  NewAddressForm({super.key});

  @override
  State<NewAddressForm> createState() => _NewAddressFormState();
}

class _NewAddressFormState extends State<NewAddressForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot>? _contributorDataStream;
  static int count = 1;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _auth.authStateChanges().listen((user) {
      setState(() {
        _user = user;
      });
    });
  }

  Future<void> _submitWaste() async {
    final data = {
      'Address': addressController.text,
      'Pincode': pinCodeController.text,
      'Landmark': landmarkController.text,
    };
    _contributorDataStream = _firestore
        .collection('UserAddress')
        .doc(_user!.uid)
        .collection("Addresses")
        .doc('addrcount')
        .snapshots();

    _contributorDataStream!.listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          count = snapshot['count'];
        });
      }
    });
    await _firestore
        .collection('UserAddress')
        .doc(_user!.uid)
        .collection('Addresses')
        .doc('a$count')
        .set(
          data,
          SetOptions(
            merge: false,
          ),
        )
        .then((value) async {
      await _firestore
          .collection('UserAddress')
          .doc(_user!.uid)
          .collection('Addresses')
          .doc('addrcount')
          .set(
           { 'count':(++count)},
            SetOptions(
            merge: true,
          ),

          );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Waste data submitted successfully')),
    );

    // Clear the input fields
    addressController.clear();
    pinCodeController.clear();
    landmarkController.clear();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController pinCodeController = TextEditingController();

  final TextEditingController landmarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Give necessary Field to add new Address"),
              reusableAddressField("Address", true, false, addressController),
              SizedBox(height: 16.0),
              TextFormField(
                controller: pinCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Pincode",
                  labelStyle:
                      TextStyle(color: Colors.deepPurple.withOpacity(0.9)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  ),
                ),
                validator: ((value) {
                  if (!(value!.length == 6)) {
                    return "Enter a valid Pincode of 6 digits";
                  }
                  return null;
                }),
              ),
              SizedBox(height: 16.0),
              reusableAddressField(
                  "Landmark", false, false, landmarkController),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await _submitWaste();
                      // Data uploaded successfully! Show success message
                      Navigator.pop(context);
                    } on Exception catch (error) {
                      // Error uploading data: Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error uploading data: $error'),
                        ),
                      );
                      print(error);
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadData(BuildContext context) async {
    String address = addressController.text;
    String pincode = pinCodeController.text;
    String landmark = landmarkController.text;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference usersCollection = firestore.collection('User');

    await usersCollection
        .add({'landmark': landmark, 'pincode': pincode, 'address': address});
  }
}
