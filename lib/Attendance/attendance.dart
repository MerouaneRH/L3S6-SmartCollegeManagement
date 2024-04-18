import 'package:flutter/material.dart';
import 'package:project_mini/comp/attendance_history_card.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFE6F4F1),
      appBar: AppBar(
        title: const Text(
          "ATTENDANCE HISTORY",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
        elevation: 0.00,
        backgroundColor: const Color(0xFF568C93),
      ), //AppBar
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const History_Card();
        },
      ),
    );
  }
}
