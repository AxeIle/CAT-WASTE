import 'package:flutter/material.dart';

class CategoryQuantity extends StatefulWidget {
  @override
  _WasteTypesScreenState createState() => _WasteTypesScreenState();
}

class _WasteTypesScreenState extends State<CategoryQuantity> {
  final Map<String, List<String>> wasteMap = {
    "Bio Waste": [
      "Food scraps",
      "Yard waste",
      "Paper",
      "Vegetable and fruit peels",
      "Coffee grounds"
    ],
    "Plastic": [
      "Plastic bottles",
      "Containers",
      "Bags",
      "Packaging materials",
      "Utensils",
      "Toys"
    ],
    "Degradable": [
      "Organic matter",
      "Compostable materials",
      "Plant-based plastics"
    ],
    "Hazardous": [
      "Chemicals",
      "Batteries",
      "Fluorescent bulbs",
      "Paints",
      "Solvents",
      "Pesticides"
    ]
  };

  Map<String, List<String>> selectedWasteItems = {};

  void updateSelectedWasteItems(
      String wasteType, String wasteItem, bool isChecked) {
    setState(() {
      if (isChecked) {
        if (!selectedWasteItems.containsKey(wasteType)) {
          selectedWasteItems[wasteType] = [];
        }
        selectedWasteItems[wasteType]!.add(wasteItem);
      } else {
        selectedWasteItems[wasteType]!.remove(wasteItem);
        if (selectedWasteItems[wasteType]!.isEmpty) {
          selectedWasteItems.remove(wasteType);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waste Types'),
      ),
      body: ListView.builder(
        itemCount: wasteMap.length,
        itemBuilder: (context, index) {
          String key = wasteMap.keys.elementAt(index);
          List<String> values = wasteMap[key]!;
          return ListTile(
            title: Text(
              key,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: values.map((value) {
                return Row(
                  children: [
                    Checkbox(
                      value: selectedWasteItems.containsKey(key)
                          ? selectedWasteItems[key]!.contains(value)
                          : false,
                      onChanged: (isChecked) {
                        updateSelectedWasteItems(key, value, isChecked!);
                      },
                    ),
                    Text(value),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(selectedWasteItems);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
