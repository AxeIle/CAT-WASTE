
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoadUserData extends StatefulWidget {
  final User? user;
  final Function(int) setSelectedIndex;
  final Function(Map<String, dynamic>?) setAddressItem;

  const LoadUserData({
    Key? key,
    required this.user,
    required this.setSelectedIndex,
    required this.setAddressItem,
  }) : super(key: key);

  @override
  _LoadUserDataState createState() => _LoadUserDataState();
}

class _LoadUserDataState extends State<LoadUserData> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('UserAddress')
          .doc(widget.user!.uid)
          .collection('Addresses')
          .doc('address')
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(
            child: Text('Add an Address'),
          );
        }

        // Access the array field 'a' under the document 'Address'
        List<dynamic>? arrayValues = snapshot.data!.get('a');
        if (arrayValues == null || arrayValues.isEmpty) {
          return Center(
            child: Text('Array field "a" is empty or does not exist'),
          );
        }

        // Display array values in a ListView
        return ListView.builder(
          itemCount: arrayValues.length,
          itemBuilder: (context, index) {
            final item = arrayValues[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.setSelectedIndex(index);
                widget.setAddressItem(item);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedIndex == index
                        ? Colors.deepPurple
                        : Colors
                            .grey, // Change outline color based on selection
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: Text(
                    item["Address"].toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                  subtitle: Text(
                    item["Landmark"].toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  trailing: Text(
                    item["Pincode"].toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  selected: _selectedIndex == index,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
