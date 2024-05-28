import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'report_form.dart';
import 'reservation_form.dart';

// ignore: must_be_immutable
class InfoForm extends StatelessWidget {
  String? roomId;
  String roomName;
  String? role;
  List<Map<String, dynamic>>? inProgressCour;
  String? courTimeRemaning;
  Map<String, dynamic>? courUpcoming;
  InfoForm(
      {super.key,
      this.role,
      this.roomId,
      required this.roomName,
      this.inProgressCour,
      this.courTimeRemaning,
      this.courUpcoming});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        //height: 450,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(232, 244, 242, 1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(0, 0, 0, 0.07),
                ),
                //color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/door2.png',
                        height: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        roomName,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            if (inProgressCour != null && inProgressCour!.isNotEmpty)
              Container(
                //height: 45,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 0.07),
                  ),
                  //color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 255, 8, 0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text("In Progress",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(19, 17, 17, 0.70),
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Poppins',
                              )),
                        ),
                        const Spacer(),
                        //Text("No cour In Progress", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold ,fontSize: 18, color: Color(0xFF323232),)),
                        if (courTimeRemaning != null &&
                            courTimeRemaning!.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(19, 0, 89, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                "$courTimeRemaning",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(54, 33, 148, 0.694),
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Poppins',
                                )),
                          ),
                      ],
                    ),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "Cour ${inProgressCour![0]['courName']}",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF323232),
                      ),
                    ),
                    if (courUpcoming != null && courUpcoming!.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(19, 255, 217, 0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text("Upcoming",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(19, 17, 17, 0.70),
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Poppins',
                            )),
                      ),
                    if (courUpcoming != null && courUpcoming!.isNotEmpty)
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Cour ${courUpcoming!['courName']}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF323232),
                        ),
                      ),
                  ],
                ),
              )
            else
              const Text(
                "No cour In Progress",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF323232),
                ),
              ),
            const SizedBox(
              height: 25,
            ),
            if (role == 'teacher')
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          insetPadding: EdgeInsets.zero,
                          child: ReservationForm(
                              roomId: roomId, roomName: roomName),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(215, 235, 215, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: Size(4.h, 40.0.w),
                    //fixedSize: Size(MediaQuery.of(context).size.width - 180, 55.0), // Set desired height
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_calendar_rounded,
                        color: Color(0xFF323232),
                        size: 30.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Reservation",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF323232),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        insetPadding: EdgeInsets.zero,
                        child: ReportForm(roomName: roomName),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(233, 16, 46, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: Size(4.h, 40.0.w),
                  //fixedSize: Size(MediaQuery.of(context).size.width - 180, 55.0), // Set desired height
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bug_report_outlined,
                      color: Color(0xFF323232),
                      size: 30.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "Report bugs",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF323232),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
