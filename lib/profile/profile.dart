import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_mini/profile/profile_card_prof.dart';
import 'package:project_mini/profile/profile_card_student.dart';
import 'package:project_mini/profile/profile_card_tech.dart';

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
                  nom: nom,
                  formation: formation,
                  groupe: groupe,
                  prenom: prenom,
                  placeOfBirth: lieuNaissance,
                  dateNaissancee: dateNaissance,
                );
              } else if (role == "teacher") {
                return PcardProf(
                  nom: nom,
                  prenom: prenom,
                  // placeOfBirth: lieuNaissance,
                  // dateNaissancee: dateNaissance,
                  //grade: grade,
                  //modules: modules,
                  role: role,
                );
              } else {
                return PcardTech(
                  nom: nom,
                  prenom: prenom,
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
      print('User prenom: $lieuNaissance');
      print('User prenom: $groupe');
      print('User prenom: $formation');
      print('User prenom: $dateNaissance');
      print('User prenom: $role');
      return; // Exit function after retrieving user data
    }

    DocumentSnapshot teacherSnapshot = await FirebaseFirestore.instance
        .collection('teacher')
        .doc(user?.uid)
        .get();

    if (teacherSnapshot.exists) {
      Map<String, dynamic> userData =
          teacherSnapshot.data() as Map<String, dynamic>;
      nom = userData['nom'];
      prenom = userData['prenom'];
      grade = userData['grade'];
      modules = userData['modules'];
      //dateNaissanceList = userData['dateNaissance'];
      // dateNaissance = dateNaissanceList?[0] +
      //     "/" +
      //     dateNaissanceList?[1] +
      //     "/" +
      //     dateNaissanceList?[2];
      role = userData['role'];
      print('User nom: $nom');
      print('User prenom: $prenom');
      //print('User prenom: $lieuNaissance');
      print('User prenom: $grade');
      print('User prenom: $modules');
      //print('User prenom: $dateNaissance');
      print('User prenom: $role');
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
      nom = userData['nom'];
      prenom = userData['prenom'];
      role = userData['role'];
      print('User nom: $nom');
      print('User prenom: $prenom');
      print('User prenom: $role');
      return;
    }
    print(
        'User document not found in Firestore collections for UID: ${user!.uid}');
  } catch (e) {
    print('Error fetching user data: $e');
  }
}
