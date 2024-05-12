import 'package:flutter/material.dart';
import 'package:project_mini/reservation/reserverooms.dart' show removeReservation;
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCard extends StatelessWidget {
  final String? reservationLocation;
  final String? reservationStatus;
  final String? reservationDate;
  final String? reservationStartTime;
  final String? reservationEndTime;
  final String? reservationId;
  
  const MyCard({
    super.key,
    required this.reservationLocation,
    required this.reservationStatus,
    required this.reservationDate,
    required this.reservationStartTime,
    required this.reservationEndTime,
    required this.reservationId,
    
  });

  @override
  Widget build(BuildContext context) {
    Color cardColor = reservationStatus == "Upcoming" ? Color(0xFFD1EBDF) : const Color.fromRGBO(231, 231, 230, 1);
    Color backgroundStatusColor = reservationStatus == "Upcoming" ? const Color.fromRGBO(0, 255, 8, 0.08) : const Color.fromRGBO(255, 0, 0, 0.06);
    String imageCard = reservationStatus == "Upcoming" ? 'images/reservation_upcoming.png' : 'images/reservation_expired.png';
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          margin: const EdgeInsets.only(bottom: 0, top: 8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
            ),
          ),
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child:Image.asset(imageCard, height: 70,),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              SizedBox(
                                width: 35,
                                child: Image.asset(
                                  'images/door.png',
                                  height: 32.0,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Text(
                                  "$reservationLocation",
                                  style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w800, fontFamily: 'Poppins',),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                decoration: BoxDecoration(
                                  color: backgroundStatusColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "$reservationStatus",
                                  style: const TextStyle( fontSize: 13, color: Color.fromRGBO(19, 17, 17, 0.70), fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              SizedBox(
                                width: 35,
                                child: Image.asset(
                                  'images/date2.png',
                                  height: 30.0,
                                ),
                              ),
                              Expanded( // Wrap Text widget with Expanded
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Text(
                                    "$reservationDate",
                                    style: const TextStyle(fontSize: 13, color: Color(0xFF323232), fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                                  ),
                                ),
                              ),       
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              SizedBox(
                                width: 35,
                                child: Image.asset(
                                  'images/time1.png',
                                  height: 30.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Text(
                                  "$reservationStartTime - $reservationEndTime",
                                  style: const TextStyle(fontSize: 13, color: Color(0xFF323232), fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                                ),
                              ),  
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (reservationStatus == 'Upcoming')  // Add conditional 
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, 
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          removeReservation(reservationId!);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Ensure background color is visible
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Adjust padding
                          textStyle: const TextStyle(fontSize: 14),  // Adjust text style if needed
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Color(0xFF323232),
                              size: 25.0,
                            ),
                            SizedBox(width: 5.0),
                            Text('Cancel Reservation', style: TextStyle(color: Color(0xFF323232),fontFamily: 'Poppins',fontWeight: FontWeight.w800),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}