import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mini/Attendance/attendance.dart';
import 'package:project_mini/auth/login_page.dart';
import 'package:project_mini/comp/navigation_prof.dart';
import 'package:project_mini/comp/navigationbarTECH.dart';
import 'package:project_mini/firebaseoptions.dart/firebase_options.dart';
import 'package:project_mini/comp/navigationBar.dart';
import 'package:project_mini/map/map.dart';
import 'package:project_mini/profile/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        "Attendance": (context) => const Attendance(),
        "login": (context) => const Login_page(),
        "profile": (context) => const Profile(),
        "navigate": (context) => const NavigateBare(),
        "navigateProf": (context) => const NavigateBare_prof(),
        "navigateTech": (context) => const NavigateBareTECH(),
        "map": (context) => const Map_page(),
      },
      debugShowCheckedModeBanner: false,
    ); 
      },
    );
   
  }
}
