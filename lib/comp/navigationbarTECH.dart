import 'package:flutter/material.dart';
import 'package:project_mini/map/map.dart';
import 'package:project_mini/profile/profile.dart';
import 'package:project_mini/report/report.dart';
import 'package:flutter/services.dart';

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
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true, // removed the extended navbar
      //backgroundColor: const Color(0xFFE6F4F1),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        height: 80,//displayWidth * .155,
        decoration: BoxDecoration(
          //color: Colors.white, // main container color
          color: const Color.fromARGB(255, 209, 229, 232),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 20, right: 20),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                i = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer( // colored containers
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == i
                      ? 130
                      : 100, // PROFILE SPACING
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == i ? 50 : 0, // BLUE HIGHLIGHTED CONTAINER
                    width: index == i ? 200 : 0, // BLUE HIGHLIGHTED CONTAINER
                    decoration: BoxDecoration(
                      color: index == i
                          ? Colors.blueAccent.withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == i
                      ? 120 // SPACEING ??
                      : 100, // SPACEING BETWEEN ICONS
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == i ? 60 : 0, // TEXT
                          ),
                          AnimatedOpacity(
                            opacity: index == i ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == i
                                  ? '${listOfStrings[index]}'
                                  : '',
                              style: TextStyle(
                                color: Colors.black54,
                                //color: Colors.blueAccent,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == i ? 20 : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: 30,
                            color: index == i
                                ? Color.fromARGB(255, 85, 93, 109)
                                : Color.fromARGB(255, 85, 93, 109),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: pages.elementAt(i),
    );
  }

  List<IconData> listOfIcons = [
    Icons.report,
    Icons.map,
    Icons.account_circle,

  ];

  List<String> listOfStrings = [
    'Report',
    'Map',
    'Profile',
  ];
}
