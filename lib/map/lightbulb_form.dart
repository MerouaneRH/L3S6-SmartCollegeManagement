import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mini/map/report_form.dart';

// ignore: must_be_immutable
class LightbulbForm extends StatefulWidget {
  String bulbId;
  String? roomId;
  String roomName;
  String? role;
  LightbulbForm({super.key, this.role, required this.bulbId, this.roomId, required this.roomName});

  @override
  State<LightbulbForm> createState() => _LightbulbFormState();
}

class _LightbulbFormState extends State<LightbulbForm> with SingleTickerProviderStateMixin {
  final databaseReference = FirebaseDatabase.instance.ref();
  bool isLightOn = false; // Initial state (assuming light is off initially)

  void toggleLight() {
    // Update Firebase value based on current state
    databaseReference.child('LightBulb/status').set(isLightOn ? "OFF" : "ON");
    setState(() {
      isLightOn = !isLightOn; // Update local state immediately
    });
  }

  @override
   void initState() {
    super.initState();
    // Listen to changes in the 'LightBulb/status' node
    databaseReference.child('LightBulb/status').onValue.listen((event) {
      final dynamic value = event.snapshot.value;
      setState(() {
        isLightOn = (value == "ON");
      });
    });
  }
  @override
  void dispose() {
    databaseReference.child('LightBulb/status').onValue.listen((event) {}).cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        //height: 450,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(30),
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
                      Image.asset('images/door2.png', height: 30,),
                      const SizedBox(width: 10,),
                      Text(
                        widget.roomName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25,),
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
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(isLightOn ? "images/lighton.png" : "images/lightoff.png", height: 75,),
                      //IconButton(onPressed: () {}, icon: Icon(Icons.lightbulb_rounded), iconSize: 50,),
                      /*Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column( 
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10), 
                              Row( 
                                crossAxisAlignment: CrossAxisAlignment.start, 
                                children: [
                                  Icon(Icons.delete_rounded, size: 25),
                                  SizedBox(width: 2),
                                  Text("Garbage level : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),*/
                    ],
                  ),
                  SizedBox(height: 15,),
                  /*ElevatedButton(
                    onPressed: (){setLevel(1); }, 
                    style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    backgroundColor: Color.fromARGB(255, 112, 145, 150)),
                    child: Text("Request a pickup",style: TextStyle(color: Color.fromARGB(255, 253, 252, 252)),) 
                  ),*/
                ],
              ),
            ),
            //SizedBox(height: 5),
            //Text('${(value1 * 100).toInt()}%'),
            /*const Text(
              "No cour In Progress", 
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold ,fontSize: 18, color: Color(0xFF323232),),
            ),*/
            const SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: ElevatedButton(
                onPressed: () {
                  print("lightbulb pressed");
                  toggleLight();
                  /*AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.topSlide,
                    title: 'Warning',          
                    descTextStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 16),
                    desc: 'Are you sure you want to request a garbage pickup ?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async { await requestGarbagePickup(widget.binId); }
                  ).show();*/
                  /*showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        insetPadding: EdgeInsets.zero,
                        child: ReservationForm(roomId: widget.roomId, roomName: widget.roomName),
                      );
                    },
                  );*/
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLightOn? Color.fromARGB(255, 255, 228, 228) : const Color.fromRGBO(215, 235, 215, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: Size(4.h, 40.0.w),
                  //fixedSize: Size(MediaQuery.of(context).size.width - 180, 55.0), // Set desired height
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.offline_bolt_outlined,
                      color: Color(0xFF323232),
                      size: 30.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      isLightOn ? 'Turn Light Off' : 'Turn Light On',
                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold ,fontSize: 18, color: Color(0xFF323232),),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        insetPadding: EdgeInsets.zero,
                        child: ReportForm(roomName: widget.roomName),
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
                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold ,fontSize: 18, color: Color(0xFF323232),),
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