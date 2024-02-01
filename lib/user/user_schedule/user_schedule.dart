import 'package:flutter/material.dart';
import 'package:login/user/user_schedule/u_s_newaddress.dart';

class UserSchedule extends StatefulWidget {
  const UserSchedule({super.key});

  @override
  _UserScheduleState createState() => _UserScheduleState();
}

class _UserScheduleState extends State<UserSchedule> {
  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              // Handle adding new address
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => NewAddressForm()));
            },
            child: Text('Add new Address'),
          ),
          SizedBox(height: 16.0),
          Text('Choose Waste Categories:'),
          CheckboxListTile(
            title: Text('Bio Waste'),
            value: selectedCategories.contains('Bio Waste'),
            onChanged: (value) {
              setState(() {
                if (value != null && value) {
                  selectedCategories.add('Bio Waste');
                } else {
                  selectedCategories.remove('Bio Waste');
                }
              });
            },
          ),
          CheckboxListTile(
            title: Text('Plastic'),
            value: selectedCategories.contains('Plastic'),
            onChanged: (value) {
              setState(() {
                if (value != null && value) {
                  selectedCategories.add('Plastic');
                } else {
                  selectedCategories.remove('Plastic');
                }
              });
            },
          ),
          CheckboxListTile(
            title: Text('Degradable'),
            value: selectedCategories.contains('Degradable'),
            onChanged: (value) {
              setState(() {
                if (value != null && value) {
                  selectedCategories.add('Degradable');
                } else {
                  selectedCategories.remove('Degradable');
                }
              });
            },
          ),
          CheckboxListTile(
            title: Text('Hazardous'),
            value: selectedCategories.contains('Hazardous'),
            onChanged: (value) {
              setState(() {
                if (value != null && value) {
                  selectedCategories.add('Hazardous');
                } else {
                  selectedCategories.remove('Hazardous');
                }
              });
            },
          ),
          // Add more CheckboxListTile widgets for additional categories
        ],
      ),
    );
  }
}
