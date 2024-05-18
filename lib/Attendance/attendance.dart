import 'package:flutter/material.dart';
import 'package:project_mini/comp/attendance_history_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

List <Map<String, String>> data = [];

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
      future: fetchAttendaceData(),
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
      if (data.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Icon(Icons.dangerous_outlined, size: 40, color: Color(0xFF323232),)),
            Center(
              child: Text("No Attendances Found !",
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ],
        );
      }
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final attendanceData = data[index]; //(const MyCard());
          return Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: History_Card(
              attendaceDate: attendanceData['attendaceDate'],
              attendaceStatus: attendanceData['attendaceStatus'],
              attendaceSubject: attendanceData['attendaceSubject'],
              attendaceDuration: attendanceData['attendaceDuration'],
            ),
          );
        }
      );
    }
    }),
    );
  }
}

String formatAttendaceDate(Timestamp attendaceDate) {
  // Create a formatter object with the desired format (month name, day, year)
  final formatter = DateFormat('MMMM dd, yyyy'); 
  // Convert the timestamp to a DateTime object
  final dateTime = attendaceDate.toDate();
  // Format the date using the formatter and return the string
  return formatter.format(dateTime);
}

Future<void> fetchAttendaceData() async {
  User? currentLoggedInStudent = FirebaseAuth.instance.currentUser;
  String? currentLoggedInStudentId = currentLoggedInStudent!.uid;
  try {
    QuerySnapshot attendaceSnapshot = await FirebaseFirestore.instance
        .collection('attendance')
        .where("studentId", isEqualTo: currentLoggedInStudentId)
        .get();

    // An empty List to store the processed data
    final List<Map<String, String>> processedAttendaceData = [];

    // Loop through each report document
    for(final attendace in attendaceSnapshot.docs) {
      Map<String, dynamic> rawAttendaceData = attendace.data() as Map<String, dynamic>;
      // Process the raw data
      final processedAttendaceDataEntry = {
        'studentId': rawAttendaceData['studentId'] as String,
        'attendaceDate': formatAttendaceDate(rawAttendaceData['attendaceDate']),
        'attendaceStatus': rawAttendaceData['attendaceStatus'] as String,
        'attendaceSubject': rawAttendaceData['attendaceSubject'] as String,
        'attendaceDuration': rawAttendaceData['attendaceDuration'] as String,
        
      };
      processedAttendaceData.add(processedAttendaceDataEntry);
    }
    data = processedAttendaceData;
    return;
    
  } catch (e) {
    print('Error fetching user data: $e');
  }
}
