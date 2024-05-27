import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_mini/Schedule/schedule_services.dart';
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
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref().child('Student');
  late StreamSubscription<DatabaseEvent> _onStudentAddedSubscription;

  @override
  void initState() {
    _onStudentAddedSubscription = _databaseReference.onValue.listen(_onStudentAdded);
    super.initState();
  }

  @override
  void dispose() {
    _onStudentAddedSubscription.cancel();
    super.dispose();
  }

  void _onStudentAdded(DatabaseEvent event) async {
    final dataSnapshot = event.snapshot;
    final id = dataSnapshot.child('ID').value as String;
    final timeAndDate = dataSnapshot.child('TimeAndDate').value as String;
    if(id ==  "" || timeAndDate == "") return;
    // Get the real student ID using the function
    String? studentId = await getRealStudentId(id);

    // Get the student current course
    //String today = getTodayDayName().toLowerCase();
    String dbAttendaceDay = getDayFromDateTimeString(timeAndDate).toLowerCase();
    Map<String, String> dbAttendanceDate = splitDateAndTime(timeAndDate);
    List<Map<String, dynamic>> courseNow = await getCurrentStudentCour(dbAttendaceDay, dbAttendanceDate['time']!);

    print("courseNow: $courseNow");
    // If the real student ID is found, mark the user as attended
    if (studentId != null && courseNow.isNotEmpty) {
      print("Card ID: $id");
      print("dbTimeAndDate: $timeAndDate");
      print("studentId: $studentId");
      if(id != "" &&  timeAndDate != ""){
        markConcernedUserAsAttended(studentId, timeAndDate, courseNow,id);
      }
    }
  }
  Map<String, String> splitDateAndTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String date = DateFormat('yyyy-MM-dd').format(dateTime);
    String time = DateFormat('HH:mm:ss').format(dateTime);
    
    return {
      'date': date,
      'time': time
    };
  }

  String getDayFromDateTimeString(String dateTimeString) {
    // Parse the date-time string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the DateTime object to get the day name
    String dayName = DateFormat('EEEE').format(dateTime);

    return dayName;
  }

  String getTodayDayName() {
    DateTime now = DateTime.now();
    return DateFormat('EEEE').format(now); // Returns the day name, e.g., 'Sunday'
  }

  Future<String?> getRealStudentId(String cardId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('student')
          .where('CardID', isEqualTo: cardId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;
      } else {
        print('Student with CardID $cardId not found');
        return null;
      }
    } catch (e) {
      print('Error fetching student ID: $e');
      return null;
    }
  }
  String convertTimestampToString(Timestamp timestamp) {
  // Convert the Timestamp to a DateTime object
  DateTime dateTime = timestamp.toDate();

  // Format the DateTime object to the desired format
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  print(formattedDate);
  return formattedDate;
}
  Future<void> addPresence(String day, String courseId, String presence) async {
  try {
    // Reference to the specific course document
    DocumentReference courseDocRef = FirebaseFirestore.instance
        .collection('schedule')
        .doc(day)
        .collection('cour')
        .doc(courseId);

    // Get the current document data
    DocumentSnapshot courseDoc = await courseDocRef.get();

    if (courseDoc.exists) {
      // Get the current presence list or initialize it if it doesn't exist
      List<dynamic> currentPresence = (courseDoc.data() as Map<String, dynamic>?)?['present'] ?? [];
      // Add the new presence string to the list
      currentPresence.add(presence);

      // Update the document with the new presence list
      await courseDocRef.update({'present': currentPresence});
      print('Presence added successfully.');
    } else {
      print('Course document does not exist.');
    }
  } catch (error) {
    print('Error adding presence: $error');
  }
}
  void markConcernedUserAsAttended(String studentId, String timeAndDate, List<Map<String, dynamic>> concernedCourse,String CardID) {

    Timestamp timeAndDateTimestamp = convertStringToTimestamp(timeAndDate);
    /*List<Map<String,dynamic>> fetchAtt = fetchAttendaceData() as List<Map<String,dynamic>>;
    for (var i = 0; i < fetchAtt.length; i++) {
     fetchAtt[i]['attendaceDate'] = convertTimestampToString(fetchAtt[i]['attendaceDate']);
    }
    print(fetchAtt);*/
    int ispresent = 0;
    concernedCourse[0]['present'].forEach((element) { 
      print(element);
      if(element == CardID){
        print("Already Marked");
        ispresent = 1;
      }
    });
    if(ispresent == 1){
      _databaseReference.update({
      'TimeAndDate': '',
      'ID': '',
    }).then((_) {
      print('Realtime Database values reset to empty strings');
    }).catchError((error) {
      print('Error resetting Realtime Database values: $error');
    });
    
      return;
    }
    FirebaseFirestore.instance.collection('attendance').add({
      'studentId': studentId,
      'attendaceDate': timeAndDateTimestamp,
      'attendaceStatus': 'Present',
      'attendaceSubject': concernedCourse[0]['courName'], // Add the subject name
      'attendaceDuration': '${concernedCourse[0]['courStartTime']} - ${concernedCourse[0]['courEndTime']}', // Add the duration
    }).then((_) {
      addPresence(getTodayDayName().toLowerCase(),concernedCourse[0]['courId'],CardID);
    // Set the Realtime Database values to empty strings after marking attendance
    _databaseReference.update({
      'TimeAndDate': '',
      'ID': '',
    }).then((_) {
      print('Realtime Database values reset to empty strings');
    }).catchError((error) {
      print('Error resetting Realtime Database values: $error');
    });
  }).catchError((error) {
    print('Error marking attendance in Firestore: $error');
  });
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

  Timestamp convertStringToTimestamp(String dateTimeString) {
  // Parse the string into a DateTime object
  DateTime parsedDateTime = DateTime.parse(dateTimeString);

  // Convert the DateTime object to a Timestamp
  Timestamp timestamp = Timestamp.fromDate(parsedDateTime);

  return timestamp;
}

  @override
  //@override
  Widget build(BuildContext context) {
    //print(isTimeWithinInterval("09:00","09:00","10:00"));
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFE6F4F1),
      appBar: AppBar(
        title: const Text(
          "ATTENDANCE HISTORY",
          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(38, 52, 77, 1)),
        ),
        titleTextStyle: TextStyle(fontFamily: 'Poppins', fontSize: 19),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        elevation: 0.00,
        backgroundColor: Color.fromRGBO(206, 228, 227, 1),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('attendance')
            .where("studentId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
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
            if (snapshot.data!.docs.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(Icons.dangerous_outlined, size: 40, color: Color(0xFF323232)),
                  ),
                  Center(
                    child: Text(
                      "No Attendances Found !",
                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
              );
            }

            data = snapshot.data!.docs.map((doc) {
              Map<String, dynamic> rawAttendaceData = doc.data() as Map<String, dynamic>;
              return {
                'studentId': rawAttendaceData['studentId'] as String,
                'attendaceDate': formatAttendaceDate(rawAttendaceData['attendaceDate']),
                'attendaceStatus': rawAttendaceData['attendaceStatus'] as String,
                'attendaceSubject': rawAttendaceData['attendaceSubject'] as String,
                'attendaceDuration': rawAttendaceData['attendaceDuration'] as String,
              };
            }).toList();

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final attendanceData = data[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15, top: 15),
                  child: History_Card(
                    attendaceDate: attendanceData['attendaceDate'],
                    attendaceStatus: attendanceData['attendaceStatus'],
                    attendaceSubject: attendanceData['attendaceSubject'],
                    attendaceDuration: attendanceData['attendaceDuration'],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

String formatAttendaceDate(Timestamp attendaceDate) {
  final formatter = DateFormat('MMMM dd, yyyy');
  final dateTime = attendaceDate.toDate();
  return formatter.format(dateTime);
}
  /*Widget build(BuildContext context) {
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
}*/

/*String formatAttendaceDate(Timestamp attendaceDate) {
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
}*/
