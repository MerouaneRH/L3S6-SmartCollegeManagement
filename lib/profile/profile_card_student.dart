import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class PCardStudent extends StatelessWidget {
  final String? username;
  final String? nom;
  final String? prenom;
  final String? placeOfBirth;
  final String? formation;
  final String? groupe;
  final String? dateNaissancee;
  const PCardStudent({
    super.key,
    required this.username,
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
            color: Color.fromRGBO(209, 229, 232, 1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color.fromARGB(255, 86, 140, 147),
              width: 2.0,
            ),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(15),
                //flex: 1,
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
          height: 360,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(209, 229, 232, 1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color.fromARGB(255, 86, 140, 147),
              //color: const Color.fromRGBO(209, 229, 232, 1),
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
                            style:  TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            '   $username',
                            style: const TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                children: [
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 35,
                    child: 
                      /*Container( 
                      height: 34, width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white30,
                      ),
                      child:*/ 
                      Image.asset(
                      'images/date2.png',
                      height: 50.0,
                    ),//),
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
                            '   $dateNaissancee',
                            style: const TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Poppins'),
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
                            style: const TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Poppins'),
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
                      'images/forma3.png',
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
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            '   $formation',
                            style: const TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Poppins'),
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
                      'images/grp3.png',
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
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            '   G$groupe',
                            style: const TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Poppins'),
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
                  Icons.logout,
                  color: Colors.black,
                  size: 25.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Logout",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
