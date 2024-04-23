import 'package:flutter/material.dart';
import 'package:project_mini/comp/cour_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

List <Map<String, String>> data = [];

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

Future<void> fetchReservationData() async {

  try {
    QuerySnapshot reservationSnapshot = await FirebaseFirestore.instance
        .collection('reservation')
        .get();

    // An empty List to store the processed data
    final List<Map<String, String>> processedReservationData = [];

    // Loop through each report document
    for(final reservation in reservationSnapshot.docs) {
      Map<String, dynamic> rawReservationData = reservation.data() as Map<String, dynamic>;
      // Process the raw data
      final processedReservationDataEntry = {
        'reservationLocation': rawReservationData['reservationLocation'] as String,
        'reservationStatus': rawReservationData['reservationStatus'] as String,
        'reservationDate': formatReservationDate(rawReservationData['reservationDate']),
        'reservationStartTime': rawReservationData['reservationStartTime'] as String,
        'reservationEndTime': rawReservationData['reservationEndTime'] as String,
        
      };
      processedReservationData.add(processedReservationDataEntry);
    }
    data = processedReservationData;
    return;
    
  } catch (e) {
    print('Error fetching user data: $e');
  }
}
