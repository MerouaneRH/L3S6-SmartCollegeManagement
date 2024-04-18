import 'package:flutter/material.dart';
import 'package:project_mini/comp/report_history_card.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "REPORT HISTORY",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle 'Solved' button press
              print('Solved button pressed');
            },
            icon: const Icon(Icons.check),
            tooltip: 'Mark as Solved',
          ),
          IconButton(
            onPressed: () {
              // Handle 'Unsolved' button press
              print('Unsolved button pressed');
            },
            icon: const Icon(Icons.close),
            tooltip: 'Mark as Unsolved',
          ),
          IconButton(
            onPressed: () {
              // Handle 'Ongoing' button press
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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => const report_history(),
      ),
    );
  }
}
