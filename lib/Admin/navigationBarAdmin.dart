import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project_mini/Admin/dashboard.dart';

class NavigateBarAdmin extends StatefulWidget {
  const NavigateBarAdmin({super.key});

  @override
  State<NavigateBarAdmin> createState() => _NavigateBareState();
}

class _NavigateBareState extends State<NavigateBarAdmin> {

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
              selectedIndex: 1,
              activeColor: const Color.fromRGBO(38, 52, 77, 1),
              color: const Color.fromRGBO(68, 77, 94, 1),
              textStyle: const TextStyle(color: Color.fromRGBO(68, 77, 94, 1), fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.bold),
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              iconSize: 40,
              gap: 5,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              tabBackgroundColor: const Color.fromRGBO(3, 96, 116, 0.1),
                tabs: [
                  GButton(
                    icon:Icons.admin_panel_settings_rounded,
                    text: 'Dashboard',
                    onPressed: () {
                  }),
                ],
            ),
        ),
      ),
      body: Dashboard()
    );
  }
}