import 'package:login/user/user_home/user_home.dart';
import 'package:login/user/user_profile/user_profile.dart';
import 'package:login/user/user_report/user_report.dart';
import 'package:login/user/user_schedule/user_schedule.dart';
import 'package:flutter/material.dart';

String activeContent = 'hello';
int _currentSelectedIndex = 0;
final _pages = [UserHome(), UserSchedule(), UserReport(), UserProfile(),];

class ScreenHome extends StatefulWidget {
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalyze Change '),
      ),
      body: _pages[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green[300],
        currentIndex: _currentSelectedIndex,
        onTap: (newIndex) {
          setState(() {
            _currentSelectedIndex = newIndex;
          });
          print(newIndex);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.home_outlined),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.schedule_outlined),
              ),
              label: 'schedule'),
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.report_outlined),
              ),
              label: 'report'),
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.person_2_outlined),
              ),
              label: 'profile'),
        ],
      ),
    );
  }
}
