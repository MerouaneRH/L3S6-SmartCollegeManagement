import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../Attendance/attendance.dart';
import '../map/display_map.dart';
import '../profile/profile.dart';

class NavigateBare extends StatefulWidget {
  const NavigateBare({super.key});

  @override
  State<NavigateBare> createState() => _NavigateBareState();
}

class _NavigateBareState extends State<NavigateBare> {
  int i = 0;
  List pages = [
    const Attendance(),
    DisplayMap(
      role: 'student',
    ),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // removed the extended navbar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          width: 200,
          height: 90,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(206, 228, 227, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: GNav(
            selectedIndex: i,
            activeColor: const Color.fromRGBO(38, 52, 77, 1),
            color: const Color.fromRGBO(68, 77, 94, 1),
            textStyle: const TextStyle(
                color: Color.fromRGBO(68, 77, 94, 1),
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.bold),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            iconSize: 40,
            gap: 5,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            tabBackgroundColor: const Color.fromRGBO(3, 96, 116, 0.1),
            tabs: [
              GButton(
                  icon: Icons.domain_verification_rounded,
                  text: 'Attendance',
                  onPressed: () {
                    setState(() {
                      i = 0;
                    });
                  }),
              GButton(
                  icon: Icons.map_outlined,
                  text: 'Map',
                  onPressed: () {
                    setState(() {
                      i = 1;
                    });
                  }),
              GButton(
                  icon: Icons.person_rounded,
                  text: 'Profile',
                  onPressed: () {
                    setState(() {
                      i = 2;
                    });
                  }),
            ],
          ),
        ),
      ),
      body: pages.elementAt(i),
    );
  }
}
