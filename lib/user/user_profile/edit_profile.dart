import 'package:flutter/material.dart';
import 'package:login/resueable/reuseable_widget.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _address = '';
  String _emailAddress = '';
  String _phoneNumber = '';
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Primary Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              reusableAddressField(
                "Full Name",
                false,
                false,
                _fullNameController,
              ),
              const SizedBox(height: 16),
              reusableAddressField(
                "Address",
                true,
                false,
                _addressController,
              ),
              const SizedBox(height: 32),
              const Text(
                'Contact Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              reusableAddressField(
                "Email Address",
                false,
                true,
                _emailAddressController,
              ),
              const SizedBox(height: 16),
              reusableAddressField(
                "Phone",
                false,
                false,
                _phoneNumberController,
                isPhone: true,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Handle form submission here
                    // Save changes
                    _fullName = _fullNameController.text;
                    _address = _addressController.text;
                    _emailAddress = _emailAddressController.text;
                    _phoneNumber = _phoneNumberController.text;
                    print(_fullName);
                    // Perform further actions like updating the database
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _fullNameController.dispose();
    _addressController.dispose();
    _emailAddressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}


