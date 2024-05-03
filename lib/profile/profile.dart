import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_mini/profile/profile_card_prof.dart';
import 'package:project_mini/profile/profile_card_student.dart';
import 'package:project_mini/profile/profile_card_tech.dart';

String? username;
String? nom;
String? prenom;
String? lieuNaissance;
String? groupe;
String? formation;
List<dynamic>? dateNaissanceList;
String? dateNaissance;
String? role;
String? grade;
String? modules;

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F4F1),
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromRGBO(38, 52, 77, 1)),
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

      ), //AppBar
      body: FutureBuilder<void>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              if (role == "student") {
                return PCardStudent(
                  username: username,
                  nom: nom,
                  formation: formation,
                  groupe: groupe,
                  prenom: prenom,
                  placeOfBirth: lieuNaissance,
                  dateNaissancee: dateNaissance,
                );
              } else if (role == "teacher") {
                return PcardProf(
                  username: username,
                  nom: nom,
                  prenom: prenom,
                  placeOfBirth: lieuNaissance,
                  dateNaissancee: dateNaissance,
                  grade: grade,
                  //modules: modules,
                  role: role,
                );
              } else {
                return PcardTech(
                  username: username,
                  nom: nom,
                  prenom: prenom,
                  dateOfBirth: dateNaissance,
                  placeOfBirth: lieuNaissance,
                  role: role,
                );
              }
            }
          }),
    );
  }
}
///////////////////////////////////////////////////////////////////////
Future<void> fetchUserData() async {
  User? user = FirebaseAuth.instance.currentUser;
  try {
    DocumentSnapshot studentSnapshot = await FirebaseFirestore.instance
        .collection('student')
        .doc(user?.uid)
        .get();
    if (studentSnapshot.exists) {
      Map<String, dynamic> userData =
          studentSnapshot.data() as Map<String, dynamic>;
      username = user!.email;
      nom = userData['nom'];
      prenom = userData['prenom'];
      lieuNaissance = userData['lieuNaissance'];
      groupe = userData['groupe'];
      formation = userData['formation'];
      dateNaissanceList = userData['dateNaissance'];
      dateNaissance = dateNaissanceList?[0] +
          "/" +
          dateNaissanceList?[1] +
          "/" +
          dateNaissanceList?[2];
      role = userData['role'];
      print('User nom: $nom');
      print('User prenom: $prenom');
      print('User lieuNaissance: $lieuNaissance');
      print('User groupe: $groupe');
      print('User formation: $formation');
      print('User dateNaissance: $dateNaissance');
      print('User role: $role');
      return; // Exit function after retrieving user data
    }

    DocumentSnapshot teacherSnapshot = await FirebaseFirestore.instance
        .collection('teacher')
        .doc(user?.uid)
        .get();

    if (teacherSnapshot.exists) {
      Map<String, dynamic> userData =
          teacherSnapshot.data() as Map<String, dynamic>;
      username = user!.email;
      nom = userData['nom'];
      prenom = userData['prenom'];
      grade = userData['grade'];
      //modules = userData['modules'];
      dateNaissanceList = userData['dateNaissance'];
      lieuNaissance = userData['lieuNaissance'];
      dateNaissance = dateNaissanceList?[0] +
          "/" +
          dateNaissanceList?[1] +
          "/" +
          dateNaissanceList?[2];
      role = userData['role'];
      print('User nom: $nom');
      print('User prenom: $prenom');
      print('User prenom: $lieuNaissance');
      print('User grade: $grade');
      //print('User modules: $modules');
      print('User prenom: $dateNaissance');
      print('User role: $role');
      return;
    }

    // If user document not found in both 'student' and 'teacher' collections, check 'technician' collection
    DocumentSnapshot technicianSnapshot = await FirebaseFirestore.instance
        .collection('technician')
        .doc(user?.uid)
        .get();

    if (technicianSnapshot.exists) {
      Map<String, dynamic> userData =
          technicianSnapshot.data() as Map<String, dynamic>;
      username = user!.email;
      nom = userData['nom'];
      prenom = userData['prenom'];
      role = userData['role'];
      dateNaissanceList = userData['dateNaissance'];
      lieuNaissance = userData['lieuNaissance'];
      dateNaissance = dateNaissanceList?[0] +
          "/" +
          dateNaissanceList?[1] +
          "/" +
          dateNaissanceList?[2];
      print('User nom: $nom');
      print('User prenom: $prenom');
      print('User role: $role');
      print('User lieuNaissance: $lieuNaissance');
      print('User dateNaissance: $dateNaissance');
      return;
    }
    print(
        'User document not found in Firestore collections for UID: ${user!.uid}');
  } catch (e) {
    print('Error fetching user data: $e');
  }
}
