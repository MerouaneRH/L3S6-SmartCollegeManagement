import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class PCardStudent extends StatelessWidget {
  final String? nom;
  final String? prenom;
  final String? placeOfBirth;
  final String? formation;
  final String? groupe;
  final String? dateNaissancee;
  const PCardStudent({
    super.key,
    required this.nom,
    required this.prenom,
    required this.placeOfBirth,
    required this.formation,
    required this.groupe,
    required this.dateNaissancee,
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
                    SizedBox(height: 20),
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Text(
                      'Student',
                      style: TextStyle(
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
          height: 300,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
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
                      'images/calen.png',
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '   $dateNaissancee',
                            style: const TextStyle(fontFamily: 'Poppins'),
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
                      'images/profile.png',
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
                            "Lieu de Naissance",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            placeOfBirth!,
                            style: const TextStyle(fontFamily: 'Poppins'),
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
                      'images/cap.png',
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
                            'Formation : ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '   $formation',
                            style: const TextStyle(fontFamily: 'Poppins'),
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
                      'images/grp.png',
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
                            'Groupe : ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '   $groupe',
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
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
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 25.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
