import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCard extends StatelessWidget {
  final String? reservationLocation;
  final String? reservationStatus;
  final String? reservationDate;
  final String? reservationStartTime;
  final String? reservationEndTime;
  const MyCard({
    super.key,
    required this.reservationLocation,
    required this.reservationStatus,
    required this.reservationDate,
    required this.reservationStartTime,
    required this.reservationEndTime,
    
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        //width: MediaQuery.of(context).size.width -20,
        //width: 300.w,
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.only(bottom: 0, top: 8),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),),
              ),
              //color: const Color(0xFF568C93),
              color: const Color.fromARGB(255, 209, 229, 232),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10,),
                        Container(
                          //width: 200,height: 40,
                          //color: Colors.green,
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(  
                            "$reservationLocation",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, fontFamily: 'Poppins',color: Color.fromRGBO(72, 82, 98, 1),)),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(195, 214, 217, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "$reservationStatus",
                            style: const TextStyle( fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'Poppins',)
                            ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        const SizedBox(width: 10,),
                        SizedBox(
                          width: 35,
                          child: Image.asset(
                            'images/date2.png',
                            height: 30.0,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(
                            "$reservationDate",
                            style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                            ),
                        ),
                        const SizedBox(width: 10,),
                        SizedBox(
                          width: 35,
                          child: Image.asset(
                            'images/time1.png',
                            height: 30.0,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(
                            "$reservationStartTime - $reservationEndTime",
                            style: const TextStyle( fontSize: 14, color: Colors.black, fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                            ),
                        ),
                      ],
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
