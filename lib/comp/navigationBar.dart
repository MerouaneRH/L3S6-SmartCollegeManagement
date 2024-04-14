import 'package:flutter/material.dart';
import 'package:project_mini/Attendance/attendance.dart';
import 'package:project_mini/profile/profile.dart';

class NavigateBare extends StatefulWidget {
  const NavigateBare({super.key});

  @override
  State<NavigateBare> createState() => _NavigateBareState();
}

class _NavigateBareState extends State<NavigateBare> {
  int i = 0;
  List pages = [
    const Attendance(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF568C93),
          type: BottomNavigationBarType.fixed,
          currentIndex: i,
          onTap: (value) {
            setState(() {
              i = value;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: Colors.white,
                size: 26,
              ),
              label: "Attendance",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance,
                color: Colors.white,
                size: 26,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: pages.elementAt(i),
    );
  }
}
