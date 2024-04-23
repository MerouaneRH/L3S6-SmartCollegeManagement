import 'package:flutter/material.dart';

class History_Card extends StatelessWidget {
  final String? attendaceDate;
  final String? attendaceStatus;
  final String? attendaceSubject;
  final String? attendaceDuration;
  const History_Card({
    super.key,
    required this.attendaceDate,
    required this.attendaceStatus,
    required this.attendaceSubject,
    required this.attendaceDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        //width: MediaQuery.of(context).size.width - 20,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
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
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    //SizedBox(width: 25,),
                    SizedBox(
                      width: 35,
                      child: Image.asset(
                        'images/date2.png',
                        height: 30.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        "$attendaceDate",
                        style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                        ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "$attendaceStatus",
                        style: const TextStyle( fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'Poppins',)
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
                          'images/book1.png',
                          height: 32.0,
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        "$attendaceSubject",
                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
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
                        'images/time1.png',
                        height: 30.0,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        "$attendaceDuration",
                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                      ),
                    ),  
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
