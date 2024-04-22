import 'package:flutter/material.dart';
import 'package:project_mini/map/map.dart';
import 'package:project_mini/profile/profile.dart';
import 'package:project_mini/report/report.dart';

class NavigateBareTECH extends StatefulWidget {
  const NavigateBareTECH({super.key});

  @override
  State<NavigateBareTECH> createState() => _NavigateBareState();
}

class _NavigateBareState extends State<NavigateBareTECH> {
  int i = 0;
  List pages = [
    const Report(),
    const Map_page(),
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
                Icons.restore,
                color: Colors.white,
                size: 26,
              ),
              label: "Report",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
                color: Colors.white,
                size: 26,
              ),
              label: "map",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box,
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
