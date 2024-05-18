import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_mini/comp/my_textfield.dart';

class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late String role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffE6F4F1),
      body: Stack(
        children: [
          Positioned(
              top: -200,
              left: -50,
              height: 500,
              width: 500,
              child: Opacity(
                opacity: .8,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff568C93),
                  ),
                ),
              )),
          const Positioned(
            top: 50, // Adjust the top position of the text
            left: 30, // Adjust the left position of the text
            child: Text(
              'SMART',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            top: 100, // Adjust the top position of the text
            left: 100, // Adjust the left position of the text
            child: Text(
              'COLLEGE ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            top: 150, // Adjust the top position of the text
            left: 50, // Adjust the left position of the text
            child: Text(
              'MANAGEMENT ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            top: 200, // Adjust the top position of the text
            left: 100, // Adjust the left position of the text
            child: Text(
              'the college in a smarter way ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: Color.fromARGB(255, 210, 199, 199),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 350),
                    child: Text(
                      'Login to your account',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24.0,
                        color: Color(0xff002930),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  MyTextField(
                    myHintText: "Your college code",
                    myController: email,
                    myIcon: const Icon(Icons.mail_outline,
                        color: Color(0xff002930), size: 25),
                  ),
                  MyTextField(
                    myHintText: "Your Birthday",
                    myController: password,
                    myIcon: const Icon(Icons.lock_outline_rounded),
                    isPassword: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: SizedBox(
                      height: 55,
                      width: 345,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff568C93)),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email.text, password: password.text);
                            await fetchUserData();

                            if (role == "student") {
                              Navigator.popAndPushNamed(context, "navigate");
                              return;
                            } else if (role == "teacher") {
                              Navigator.popAndPushNamed(
                                  context, "navigateProf");
                              return;
                            } else if (role == "agent") {
                              Navigator.popAndPushNamed(
                                  context, "navigateAgent");
                            } else if (role == "admin") {
                              Navigator.popAndPushNamed(
                                  context, "navigateAdmin");
                              return;
                            } else {
                              Navigator.popAndPushNamed(
                                  context, "navigateTech");
                            }
                          } catch (e) {
                            print('No user found for that email.');

                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'ERROR',
                              desc: 'Error in Email or Password',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      DocumentSnapshot studentSnapshot = await FirebaseFirestore.instance
          .collection('student')
          .doc(user!.uid)
          .get();

      if (studentSnapshot.exists) {
        Map<String, dynamic> userData =
            studentSnapshot.data() as Map<String, dynamic>;
        role = userData['role'];
        return;
      }

      DocumentSnapshot teacherSnapshot = await FirebaseFirestore.instance
          .collection('teacher')
          .doc(user.uid)
          .get();

      if (teacherSnapshot.exists) {
        Map<String, dynamic> userData =
            teacherSnapshot.data() as Map<String, dynamic>;
        role = userData['role'];
        return;
      }

      DocumentSnapshot agentSnapshot = await FirebaseFirestore.instance
          .collection('agent')
          .doc(user.uid)
          .get();

      if (agentSnapshot.exists) {
        Map<String, dynamic> userData =
            agentSnapshot.data() as Map<String, dynamic>;
        role = userData['role'];
        return;
      }
      DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc(user.uid)
          .get();

      if (adminSnapshot.exists) {
        Map<String, dynamic> userData =
            adminSnapshot.data() as Map<String, dynamic>;
        role = userData['role'];
        return;
      }

      DocumentSnapshot technicianSnapshot = await FirebaseFirestore.instance
          .collection('technician')
          .doc(user.uid)
          .get();

      if (technicianSnapshot.exists) {
        Map<String, dynamic> userData =
            technicianSnapshot.data() as Map<String, dynamic>;
        role = userData['role'];
        return;
      }
      print(
          'User document not found in Firestore collections for UID: ${user.uid}');
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return;
  }
}
