import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile.dart';

// ignore: must_be_immutable
class PcardTech extends StatelessWidget {
  final String? username;
  final String? nom;
  final String? prenom;
  final String? dateOfBirth;
  final String? placeOfBirth;
  final String? role;

  const PcardTech({
    super.key,
    required this.username,
    required this.nom,
    required this.prenom,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.role,
  });
  @override
  Widget build(BuildContext context) {
    String fullName = "${nom!.toUpperCase()} ${prenom!.toUpperCase()}";
    return ListView(
      children: [
        SizedBox(height: 10.h),
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(209, 229, 232, 1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color.fromARGB(255, 86, 140, 147),
              width: 2.0,
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'images/profile.png',
                  ),
                  radius: 50.0,
                  backgroundColor: Colors.black,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        fullName,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Text(
                      '$role',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'University of Tlemcen - Faculty of Sciences',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          height: 230,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(209, 229, 232, 1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color.fromARGB(255, 86, 140, 147),
              width: 2.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 35,
                    child: Image.asset(
                      'images/idv2.png',
                      height: 50.0,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          const Text(
                            'ID : ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              '   $username',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 35,
                    child: Image.asset(
                      'images/date2.png',
                      height: 50.0,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          const Text(
                            'Date of Birth : ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            '   $dateNaissance',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 35,
                    child: Image.asset(
                      'images/loc3.png',
                      height: 50.0,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          const Text(
                            "Lieu de Naissance : ",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            '   $placeOfBirth',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              20, 10, 20, 10), // Adjust padding values as needed
          child: ElevatedButton(
            // Use ElevatedButton for a raised button
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "login");
              print('Logout button pressed!');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 214, 66, 66),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              minimumSize: Size(MediaQuery.of(context).size.width,
                  55.0), // Set desired height
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 25.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Logout",
                  style: TextStyle(
                      fontFamily: 'Poppins', fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
