import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'report_form.dart';

// ignore: must_be_immutable
class TrashBinForm extends StatefulWidget {
  String binId;
  String? roomId;
  String roomName;
  String? role;
  TrashBinForm(
      {super.key,
      this.role,
      required this.binId,
      this.roomId,
      required this.roomName});

  @override
  State<TrashBinForm> createState() => _TrashBinFormState();
}

class _TrashBinFormState extends State<TrashBinForm>
    with SingleTickerProviderStateMixin {
  final databaseReference = FirebaseDatabase.instance.ref();
  //int garbageLevel = 0;
  double value1 = 0.0;
  late AnimationController _controller;
  late Animation<double> _animation;

  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: value1).animate(_controller)
      ..addListener(() {
        setState(() {}); // Trigger rebuild when animation value changes
      });
    // Listen to changes in the 'garbage_level' node
    databaseReference.child('garbage/Lvl').onValue.listen((event) {
      final dynamic value = event.snapshot.value;
      setState(() {
        value1 = value != null ? double.parse(value.toString()) / 100 : 0;
        setLevel(value1);
      });
    });
  }

  void setLevel(double newLevel) {
    setState(() {
      value1 = newLevel.clamp(0.0, 1.0);
      // Reset the animation
      _animation =
          Tween(begin: _animation.value, end: value1).animate(_controller)
            ..addListener(() {
              setState(() {});
            });
      _controller.forward(from: 0.0);
    });
  }

  @override
  void dispose() {
    databaseReference.child('garbage/Lvl').onValue.listen((event) {}).cancel();
    _controller.dispose();
    super.dispose();
  }

  Color _getProgressColor(double value) {
    if (value < 0.5) {
      return Colors.green;
    } else if (value < 0.9) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  bool isPickupButtonEnabled() {
    return value1 >= 0.9; // Enable button if value1 is greater than 90%
  }

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
                        widget.roomName,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
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
                                  Text("Garbage level : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: LinearProgressIndicator(
                      value: _animation.value,
                      borderRadius: BorderRadius.circular(8),
                      minHeight: 25,
                      color: _getProgressColor(_animation.value),
                    ),
                  ),
                  Center(
                      child: Text(
                    '${(value1 * 100).toInt()}%',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        fontSize: 17),
                  )),
                  SizedBox(
                    height: 15,
                  ),
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
            const SizedBox(
              height: 25,
            ),
            if (widget.role != 'agent')
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: ElevatedButton(
                  onPressed: isPickupButtonEnabled()
                      ? () {
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.question,
                              animType: AnimType.topSlide,
                              title: 'Warning',
                              descTextStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              desc:
                                  'Are you sure you want to request a garbage pickup ?',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () async {
                                await requestGarbagePickup(widget.binId);
                              }).show();
                          /*showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        insetPadding: EdgeInsets.zero,
                        child: ReservationForm(roomId: widget.roomId, roomName: widget.roomName),
                      );
                    },
                  );*/
                        }
                      : null,
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
                        Icons.delete_outline_rounded,
                        color: Color(0xFF323232),
                        size: 25.0,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "Request a pickup",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
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

  Future<void> requestGarbagePickup(String binId) async {
    try {
      // Get reference to the document
      DocumentReference binRef =
          FirebaseFirestore.instance.collection('trashbin').doc(binId);

      // Update the document
      await binRef.update({
        'binIsPicked': false,
        'binIsFull': true,
      });

      print('Pickup requested successfully.');
    } catch (error) {
      print('Error requesting a pickup: $error');
      // Handle error as needed
    }
  }
}
