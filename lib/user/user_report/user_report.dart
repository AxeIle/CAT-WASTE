import 'package:flutter/material.dart';
import 'package:login/user/user_report/camera.dart';

class UserReport extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<UserReport> {
  List<String> _selectedWasteCollectionIssues = [];
  List<String> _selectedNeighbourhoodIssues = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Issues related to waste collection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._getWasteCollectionIssues(),
            const SizedBox(height: 32),
            const Text(
              'Issues in the neighbourhood',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._getNeighbourhoodIssues(),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraPage()),
                  );
                },
                child: Text('If any other reason'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getWasteCollectionIssues() {
    List<Widget> issues = [];
    for (final issue in [
      'Overflowing bins',
      'Missed collections',
      'Littering',
      'Improper waste sorting',
      'Other (please specify)',
    ]) {
      final localIssue = issue;
      issues.add(
        _buildIssueCheckbox(localIssue, _selectedWasteCollectionIssues,
            (value) {
          setState(() {
            if (value!) {
              _selectedWasteCollectionIssues.add(issue);
            } else {
              _selectedWasteCollectionIssues.remove(issue);
            }
          });
        }),
      );
    }
    return issues;
  }

  List<Widget> _getNeighbourhoodIssues() {
    List<Widget> issues = [];
    for (final issue in [
      'Illegal Waste dumping',
      'Burning harmful waste (Green House gas emitters)',
    ]) {
      final localIssue = issue;
      issues.add(
        _buildIssueCheckbox(localIssue, _selectedNeighbourhoodIssues, (value) {
          setState(() {
            if (value!) {
              _selectedNeighbourhoodIssues.add(issue);
            } else {
              _selectedNeighbourhoodIssues.remove(issue);
            }
          });
        }),
      );
    }
    return issues;
  }

  Widget _buildIssueCheckbox(
    String issue,
    List<String> selectedIssues,
    void Function(bool?) onChangeValue,
  ) {
    return Row(
      children: [
        Checkbox(
          value: selectedIssues.contains(issue),
          onChanged: onChangeValue,
        ),
        Text(issue),
      ],
    );
  }
}
