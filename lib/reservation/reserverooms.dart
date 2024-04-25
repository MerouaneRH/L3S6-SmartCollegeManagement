import 'package:flutter/material.dart';
import 'package:project_mini/comp/cour_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

List <Map<String, dynamic>> data = [];

class ReserveRooms extends StatefulWidget {
  const ReserveRooms({super.key});

  @override
  State<ReserveRooms> createState() => _ReserveRoomsState();
}

class _ReserveRoomsState extends State<ReserveRooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffE6F4F1),
      backgroundColor: const Color(0xffE6F4F1),
      appBar: AppBar(
        
        title: const Text(
          "RESERVATION ROOM",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50)),
        ),
        elevation: 0.00,
        backgroundColor: const Color(0xFF568C93),
        
      ), //AppBar
      extendBodyBehindAppBar: true, //white background remove
      body: FutureBuilder<void>(
        future: fetchReservationData(),
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
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final reservationData = data[index]; //(const MyCard());
            return Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 15),
              child: MyCard(
                reservationLocation: reservationData['reservationLocation'],
                reservationStatus: reservationData['reservationStatus'],
                reservationDate: reservationData['reservationDate'],
                reservationStartTime: reservationData['reservationStartTime'],
                reservationEndTime: reservationData['reservationEndTime'],
              ),
            );
          }
        );
      }
      }),
    );
  }
}

String formatReservationDate(Timestamp reservationDate) {
  // Create a formatter object with the desired format (month name, day, year)
  final formatter = DateFormat('MMMM dd, yyyy'); 
  // Convert the timestamp to a DateTime object
  final dateTime = reservationDate.toDate();
  // Format the date using the formatter and return the string
  return formatter.format(dateTime);
}
//FUTURE USE ACTIVE STATUS
bool isReservationActive(Map<String, dynamic> reservation) {
  // Get the current date and time
  DateTime now = DateTime.now();
  // Convert timestamps to DateTime objects
  DateTime reservationStart = formatReservationDateTime(
      reservation['reservationDate'] as Timestamp, reservation['reservationStartTime'] as String);
  DateTime reservationEnd = formatReservationDateTime(
      reservation['reservationDate'] as Timestamp, reservation['reservationEndTime'] as String);
  // Check if the current date and time is between the reservation start and end time
  return now.isAfter(reservationStart) && now.isBefore(reservationEnd);
}

bool isReservationExpired(Map<String, dynamic> reservation) {
  DateTime now = DateTime.now();
  DateTime reservationEnd = formatReservationDateTime(
      reservation['reservationDate'] as Timestamp, reservation['reservationEndTime'] as String);
  return now.isAfter(reservationEnd);
}

DateTime formatReservationDateTime(Timestamp reservationDate, String reservationTime) {
  // Convert timestamp to DateTime
  DateTime reservationDateTime = reservationDate.toDate();

  // Combine date and time (assuming 'reservationTime' is in HH:MM format)
  return DateTime(reservationDateTime.year, reservationDateTime.month, reservationDateTime.day,
      int.parse(reservationTime.split(':')[0]), int.parse(reservationTime.split(':')[1])); // Parse hour and minute
}

Future<void> fetchReservationData() async {
  User? currentLoggedInTeacher = FirebaseAuth.instance.currentUser;
  String? currentLoggedInTeacherId = currentLoggedInTeacher!.uid;
  try {
    QuerySnapshot reservationSnapshot = await FirebaseFirestore.instance
        .collection('reservation')
        .where("teacherId", isEqualTo: currentLoggedInTeacherId)
        .get();

    // An empty List to store the processed data
    final List<Map<String, dynamic>> processedReservationData = [];
    // Loop through each report document
    for(final reservation in reservationSnapshot.docs) {
      Map<String, dynamic> rawReservationData = reservation.data() as Map<String, dynamic>;
      // Process the raw data
      final processedReservationDataEntry = {
        'reservationId': rawReservationData['reservationId'] as String,
        'reservationLocation': rawReservationData['reservationLocation'] as String,
        'reservationStatus': rawReservationData['reservationStatus'] as String,
        'reservationDate': formatReservationDate(rawReservationData['reservationDate']),
        'reservationStartTime': rawReservationData['reservationStartTime'] as String,
        'reservationEndTime': rawReservationData['reservationEndTime'] as String,
        'teacherId': rawReservationData['teacherId'] as String,
        'isActive': isReservationActive(rawReservationData), // Add this line to check if active
        'isExpired': isReservationExpired(rawReservationData), // Add this line to check if active
        
      };
      //updateReservationStatus(processedReservationDataEntry);
    processedReservationData.add(processedReservationDataEntry);
    }
    data = processedReservationData;
    return;
    
  } catch (e) {
    print('Error fetching user data: $e');
  }
}

Future<void> updateReservationStatus(Map<String, dynamic> reservation) async {
  // Use existing isActive and isExpired values
  bool isActive = reservation['isActive'] as bool;
  bool isExpired = reservation['isExpired'] as bool;
  // Determine the updated reservation status based on isActive and isExpired
  String newStatus;
  if (isActive && !isExpired) {
    newStatus = 'Ongoing';
  } else if (!isActive && !isExpired) {
    newStatus = 'Upcoming';
  } else if (!isActive && isExpired) {
    newStatus = 'Expired';
  } else {
    newStatus = 'Error'; // Handle unexpected case (shouldn't occur)
  }
  //print(reservation);
  // Update the reservation document in Firestore
  try {
    await FirebaseFirestore.instance
        .collection('reservation')
        .doc(reservation['reservationId'] as String) // Assuming 'reservationId' exists
        .update({'reservationStatus': newStatus});
    print('Reservation status updated successfully');
  } catch (e) {
    print('Error updating reservation status: $e');
  }
}
// FUTURE USE
Future<void> addNewReservation({
  required String reservationLocation,
  required String reservationDate,
  required String reservationStartTime,
  required String reservationEndTime,
  required String teacherId,
}) async {
  final db = FirebaseFirestore.instance;

  // Create a reference to the new document with auto-generated ID
  final newReservationRef = await db.collection("reservation").add({});

  // Get the auto-generated ID from the reference
  final String reportId = newReservationRef.id;

  // Prepare reservation data with reportId
  final reservationData = {
    "reservationLocation": reservationLocation,
    "reservationStatus": "Upcoming",
    "reservationDate": reservationDate,
    "reservationStartTime": reservationStartTime,
    "reservationEndTime": reservationEndTime,
    "teacherId": teacherId,
    "reservationId": reportId,
  };

  // Set the data on the document
  await newReservationRef.set(reservationData);

  print("New reservation added with ID: $reportId");
}
