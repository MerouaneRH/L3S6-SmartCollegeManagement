import 'package:flutter/material.dart';
import 'package:project_mini/comp/cour_history.dart';

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
          style: TextStyle(fontWeight: FontWeight.bold),
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
      body: ListView.builder(
        itemBuilder: (context, index) => const MyCard(),
      ),
      // bottomNavigationBar: ClipRRect(
      //   borderRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(50.0),
      //     topRight: Radius.circular(50.0),
      //   ),
      // ),
    );
  }
}
