import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mini/auth/login_page.dart';
import 'package:project_mini/comp/navigation_prof.dart';
import 'package:project_mini/comp/navigationbarAgent.dart';
import 'package:project_mini/comp/navigationbarTECH.dart';
import 'package:project_mini/firebaseoptions.dart/firebase_options.dart';
import 'package:project_mini/comp/navigationBar.dart';
import 'package:project_mini/profile/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if(user == null) {
      print("User is currently Signed Out!");
    } else {
      print("${user.email} is Signed In!");
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (_, child) {
        return MaterialApp(
          home: const Login_page(),
          routes: {
            "login": (context) => const Login_page(),
            "profile": (context) => const Profile(),
            "navigate": (context) => const NavigateBare(),
            "navigateProf": (context) => const NavigateBare_prof(),
            "navigateTech": (context) => const NavigateBareTECH(),
            "navigateAgent": (context) => const NavigateBareAgent(),
            //"map": (context) => DisplayMap(role:),
          },
          debugShowCheckedModeBanner: false,
        ); 
      },
    );
  }
}
