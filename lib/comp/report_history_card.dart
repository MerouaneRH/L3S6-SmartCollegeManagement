import 'package:flutter/material.dart';

class report_history extends StatelessWidget {
  const report_history({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.only(bottom: 0, top: 8),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),),
              ),
              //color: const Color(0xFF568C93),
              color: const Color.fromARGB(255, 209, 229, 232),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const SizedBox(width: 150,),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(195, 214, 217, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Unsolved report #171",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'Poppins',)
                            ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 20, 0),
                          child: const Text(
                            "10/03/2024",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Poppins',color: Color.fromRGBO(72, 82, 98, 1),//color: Colors.blueGrey.shade400
                            )
                            ),
                        ),

                      ],
                    ),
                    //const SizedBox(height: 10,),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 150,height: 150,
                              //color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Image.asset(
                                  'images/alert7.png',
                                  height: 100,
                                ),
                              ),
                            ), 
                          ],
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width * 0.9) - 170,height: 150,
                          //color: Colors.blue,
                          child: Column( 
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 41,
                                    padding: EdgeInsets.fromLTRB(0, 10, 5, 5),
                                    //width: 200,height: 40,
                                    //color: Colors.green,
                                    child: const Text(  
                                      "Amphitheatre 2",
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, fontFamily: 'Poppins',color: Color.fromRGBO(72, 82, 98, 1),)),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 41,
                                    padding: EdgeInsets.fromLTRB(5, 17, 5, 1),
                                    //color: Colors.green,
                                    child: const Text(  
                                      "Sent 23min ago",
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Poppins',color: Color.fromRGBO(72, 82, 98, 1),)),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    //width: 300,height: 50,
                                    padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                    //color: Colors.grey,
                                    child: const Text(
                                      "Hardware related issue",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Poppins',color: Color.fromRGBO(72, 82, 98, 1),),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 75,
                                //color: Colors.red,
                                child:
                                const Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'The garbage sensor is failing to accurately monitor levels however it seems to be working whenever the button is pressed twice.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ], 
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          // Use ElevatedButton for a raised button
                          onPressed: () {
                            print('Mark as Resolved button pressed!');
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Poppins',),
                            backgroundColor: const Color.fromARGB(255, 68, 77, 94),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            minimumSize: const Size(15, 45.0), // Set desired height
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              SizedBox(width: 2.0),
                              Text(
                                "Mark as Resolved",
                                style: TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print('Mark as In Progress button pressed!');
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Poppins',),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            minimumSize: const Size(15, 45.0), // Set desired height
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.hourglass_top,
                                color: Color.fromARGB(255, 68, 77, 94),
                                size: 20.0,
                              ),
                              Text(
                                "Mark as In Progress",
                                style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 68, 77, 94),),
                              ),
                            ],
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
