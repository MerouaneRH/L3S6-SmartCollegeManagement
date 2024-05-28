import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'createuser.dart';
import 'deleteuser.dart';
import 'updateUser.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final List<Map<String, dynamic>> gridItems = [
    {'title': 'Create User', 'icon': Icons.person_add},
    {'title': 'Manage User', 'icon': Icons.settings},
    {
      'title': 'Delete User',
      'icon': Icons.delete_outline
    }, // Duplicate for demo
    {'title': '~~~~~~', 'icon': Icons.person_off}, // Placeholder icon
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6F4F1),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "login");
            },
          ),
        ],
        title: const Text(
          "MANAGE YOUR APP",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromRGBO(38, 52, 77, 1)),
        ),
        titleTextStyle: TextStyle(fontFamily: 'Poppins', fontSize: 19),
        titleSpacing: 00.0,
        centerTitle: true,
        //toolbarHeight: 50.0,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            //topLeft: Radius.circular(30),
            //topRight: Radius.circular(30),
          ),
        ),
        elevation: 0.00,
        //backgroundColor: const Color(0xFF568C93),
        backgroundColor: Color.fromRGBO(206, 228, 227, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two columns
              mainAxisSpacing: 10, // Vertical spacing
              crossAxisSpacing: 10, // Horizontal spacing
            ),
            padding: const EdgeInsets.all(20),
            itemCount: gridItems.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (gridItems[index]['title'] == 'Delete User') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: const Color(0xffE6F4F1),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.57,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: DeleteUser(),
                          ),
                        );
                        // DeleteStudentData("zbi");
                      },
                    );
                  }
                  if (gridItems[index]['title'] == 'Manage User') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: const Color(0xffE6F4F1),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.57,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: UpdateUser(),
                          ),
                        );

                        // DeleteStudentData("zbi");
                      },
                    );
                  }

                  if (gridItems[index]['title'] == 'Create User') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: const Color(0xffE6F4F1),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.57,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: createuser(),
                          ),
                        );

                        // DeleteStudentData("zbi");
                      },
                    );
                  }

                  if (gridItems[index]['title'] == '~~~~~~') {}
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        gridItems[index]['icon'],
                        size: 40,
                        color: const Color.fromRGBO(38, 52, 77, 1),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        gridItems[index]['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
