import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Admin/navigationBarAdmin.dart';
import 'auth/fetch_role.dart';
import 'auth/login_page.dart';
import 'comp/navigationBar.dart';
import 'comp/navigation_prof.dart';
import 'comp/navigationbarAgent.dart';
import 'comp/navigationbarTECH.dart';
import 'firebaseoptions.dart/firebase_options.dart';
import 'profile/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print("User is currently Signed Out!");
    } else {
      print("${user.email} is Signed In!");
    }
  });
  String? role = await FetchRole().fetchUserDataa();
  // Fetch user role
  runApp(MyApp(role: role));
}

class MyApp extends StatelessWidget {
  final String? role;
  const MyApp({super.key, this.role});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          home: role == "student"
              ? const NavigateBare()
              : role == "teacher"
                  ? const NavigateBare_prof()
                  : role == "agent"
                      ? const NavigateBareAgent()
                      : role == "admin"
                          ? const NavigateBarAdmin()
                          : role == null
                              ? const Login_page()
                              : const NavigateBareTECH(),
          routes: {
            "login": (context) => const Login_page(),
            "profile": (context) => const Profile(),
            "navigate": (context) => const NavigateBare(),
            "navigateProf": (context) => const NavigateBare_prof(),
            "navigateTech": (context) => const NavigateBareTECH(),
            "navigateAgent": (context) => const NavigateBareAgent(),
            "navigateAdmin": (context) => const NavigateBarAdmin(),
            //"map": (context) => DisplayMap(role:),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
