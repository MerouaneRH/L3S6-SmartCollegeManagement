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
        margin: EdgeInsets.all(displayWidth * .05),
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
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
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
                      ? 170
                      : 130,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == i ? displayWidth * .12 : 0,
                    width: index == i ? displayWidth * .32 : 0,
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
                      ? displayWidth * .31
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == i ? displayWidth * .13 : 0,
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
                                index == i ? displayWidth * .03 : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .076,
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
    'Report Logs',
    'Map',
    'Profile',
  ];
}
