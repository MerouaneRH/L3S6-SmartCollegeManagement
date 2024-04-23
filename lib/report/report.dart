import 'package:flutter/material.dart';
import 'package:project_mini/comp/report_history_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

List <Map<String, String>> data = [];

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFE6F4F1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "REPORT HISTORY",
          style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('Solved button pressed');
            },
            icon: const Icon(Icons.check),
            tooltip: 'Mark as Solved',
          ),
          IconButton(
            onPressed: () {
              print('Unsolved button pressed');
            },
            icon: const Icon(Icons.close),
            tooltip: 'Mark as Unsolved',
          ),
          IconButton(
            onPressed: () {
              print('Ongoing button pressed');
            },
            icon: const Icon(Icons.hourglass_bottom),
            tooltip: 'Mark as Ongoing',
          ),
        ],
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
      ),

      body: FutureBuilder<void>(
          future: fetchReportData(),
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
              final reportData = data[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 15), 
                child: report_history(
                  reportId: reportData['reportId'], // Access specific properties
                  reportStatus: reportData['reportStatus'],
                  reportDate: reportData['reportDate'],
                  reportIssueType: reportData['reportIssueType'],
                  reportLocation: reportData['reportLocation'],
                  reportTime: reportData['reportTime'],
                  timeSinceReport: reportData['timeSinceReport'],
                  reportDescription: reportData['reportDescription'],
                ),
            );}
          );
          }
        }),
    );
  }
}

String formatDate(String reportDay) {
  // Split the date string into day, month, and year components
  final List<String> dateParts = reportDay.split('/');

  // Rearrange and combine the components in the desired format
  return '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';
}

// Helper functions to format reportDate
String formatReportDate(Timestamp reportDate) {
  final DateTime dateTime = reportDate.toDate();
  final formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(dateTime);
}

String formatReportTime(Timestamp reportDate) {
  final DateTime dateTime = reportDate.toDate();
  final formatter = DateFormat('HH:mm'); // Use HH for 24-hour format
  return formatter.format(dateTime);
}

String calculateTimeSinceReport(String reportDay, String reportTime) {
  String correctedReportDayFormat = formatDate(reportDay);
  final reportDateTime = DateTime.parse('$correctedReportDayFormat $reportTime'); // Adjust format

  // Get current date and time
  final now = DateTime.now();

  // Calculate difference in seconds
  final difference = now.difference(reportDateTime).inSeconds;

  // Determine time unit and calculate value
  if (difference < 60) {
    return '$difference seconds ago';
  } else if (difference < 3600) {
    final minutes = (difference / 60).floor();
    return '$minutes minute(s) ago';
  } else if (difference < 86400) {
    final hours = (difference / 3600).floor();
    return '$hours hour(s) ago';
  } else {
    // Handle days or more (adjust as needed)
    final days = (difference / 86400).floor();
    return '$days day(s) ago';
  }
}

Future<void> fetchReportData() async {

  try {
    QuerySnapshot reportSnapshot = await FirebaseFirestore.instance
        .collection('report')
        .get();

    // An empty List to store the processed data
    final List<Map<String, String>> processedReportData = [];

    // Loop through each report document
    for(final report in reportSnapshot.docs) {
      Map<String, dynamic> rawReportData = report.data() as Map<String, dynamic>;
      // Process the raw data
      final processedReportDataEntry = {
        'reportId': rawReportData['reportId'] as String,
        'reportStatus': rawReportData['reportStatus'] as String,
        'reportDate': formatReportDate(rawReportData['reportDate']),
        'reportIssueType': rawReportData['reportIssueType'] as String,
        'reportLocation': rawReportData['reportLocation'] as String,
        'reportTime': formatReportTime(rawReportData['reportDate']),
        'timeSinceReport': calculateTimeSinceReport(formatReportDate(rawReportData['reportDate']), formatReportTime(rawReportData['reportDate'])),
        'reportDescription': rawReportData['reportDescription'] as String,
        
      };
      processedReportData.add(processedReportDataEntry);
    }
    data = processedReportData;
    return;
    
  } catch (e) {
    print('Error fetching user data: $e');
  }
}
