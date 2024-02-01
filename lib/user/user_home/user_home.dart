import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  // Use a GlobalKey to provide a unique identifier for the DropdownButtonFormField
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _list = [
    'Apple',
    'Orange',
    'Pine Apple',
  ];

  UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: DropdownButtonFormField(
          key:
              UniqueKey(), // Use UniqueKey as the key for DropdownButtonFormField
          items: _list.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (String? value) {
            print(value);
          },
        ),
      ),
    );
  }
}
