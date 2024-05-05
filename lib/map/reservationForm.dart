import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationForm extends StatefulWidget {
  const ReservationForm({super.key});

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {

  final TextEditingController _reservationDate = TextEditingController();
  final TextEditingController _reservationStartTime = TextEditingController();
  final TextEditingController _reservationEndTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? currentLoggedInTeacher = FirebaseAuth.instance.currentUser;
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(30),
          color: Color.fromRGBO(232, 244, 242, 1),
        ),
      child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            
            //SizedBox(height: 20,),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(0, 0, 0, 0.07),
                ),       
                //color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    //color: Colors.red,
                    children: [
                      Image.asset('images/door2.png', height: 30,),
                      SizedBox(width: 10,),
                      Text(
                        'Amphitheatre 2',
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
            SizedBox(height: 25,),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(0, 0, 0, 0.07),
                ),       
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40,right: 40),
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'Poppins',),
                      textAlign: TextAlign.center,
                      readOnly: true,
                      controller: _reservationDate,
                      decoration: const InputDecoration(
                        hintText: '-- / -- / ----',
                        hintStyle: TextStyle(fontFamily: 'Poppins',),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(211, 229, 233, 1),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(Icons.calendar_month_outlined, size: 30,),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), 
                          firstDate: DateTime(2024), 
                          lastDate: DateTime(2025),
                        );
                        if(pickDate != null) {
                          setState(() {
                            _reservationDate.text = DateFormat('dd-MM-yyyy').format(pickDate);
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(children: [
                    //Text("From : "),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        style: TextStyle(fontFamily: 'Poppins',),
                        textAlign: TextAlign.center,
                        readOnly: true,
                        controller: _reservationStartTime,
                        decoration: const InputDecoration(
                          hintText: '-- : --',
                          hintStyle: TextStyle(fontFamily: 'Poppins',),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(211, 229, 233, 1),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.access_time, size: 30,),
                          ),
                        ),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context, 
                            initialTime: TimeOfDay.now(),
                            /*initialTime: TimeOfDay.now().hour >= 8 && TimeOfDay.now().hour < 18
                              ? TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute)
                              : const TimeOfDay(hour: 8, minute: 0),*/
                          );
                          if(pickedTime != null) {
                            // Format the time without AM/PM indicator
                            String formattedHour = pickedTime.hour.toString().padLeft(2, '0');
                            String formattedMinute = pickedTime.minute.toString().padLeft(2, '0');
                            String formattedTime = '$formattedHour:$formattedMinute';
                            setState(() {
                              //_reservationStartTime.text = pickedTime.format(context);
                              _reservationStartTime.text = formattedTime;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    //Text("To : "),
                    Flexible(
                      flex: 1,
                      child: TextField(
                         style: TextStyle(fontFamily: 'Poppins',),
                        textAlign: TextAlign.center,
                        readOnly: true,
                        controller: _reservationEndTime,
                        decoration: const InputDecoration(
                          hintText: '-- : --',
                          hintStyle: TextStyle(fontFamily: 'Poppins',),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(211, 229, 233, 1),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.access_time, size: 30,),
                          ),
                        ),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context, 
                            initialTime: TimeOfDay.now(),
                            /*initialTime: TimeOfDay.now().hour >= 8 && TimeOfDay.now().hour < 18
                              ? TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute)
                              : const TimeOfDay(hour: 8, minute: 0),*/
                          );
                          if(pickedTime != null) {
                            // Format the time without AM/PM indicator
                            String formattedHour = pickedTime.hour.toString().padLeft(2, '0');
                            String formattedMinute = pickedTime.minute.toString().padLeft(2, '0');
                            String formattedTime = '$formattedHour:$formattedMinute';
                            setState(() {
                              //_reservationEndTime.text = pickedTime.format(context);
                              _reservationEndTime.text = formattedTime;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                  ),
                ],
              ),      
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: ElevatedButton(
              onPressed: () async {
                  bool hasCollision = await isBookingCollision(stringToTimestamp("05-05-2024"),_reservationStartTime.text, _reservationEndTime.text);
                  print(hasCollision);
                  //print("HHHHH");
                  // bool hasCollision = await isBookingCollision(stringToTimestamp("05-05-2024"),"01:40", "01:45");
                  // print(hasCollision); // This will print either true or false
                  //addNewReport(reportLocation: "Amphitheatre 3", reportIssueType: reportType.selectedOptions[0].value, reportDescription: reportDescription.text);
                  if(currentLoggedInTeacher != null) { // TODO: CHECK WHETHER IT'S A TEACHER OR NOT
                    if(hasCollision == false){
                      addNewReservation(
                        reservationLocation: "Amphitheatre 2", 
                        reservationDate: _reservationDate.text, 
                        reservationStartTime: _reservationStartTime.text, 
                        reservationEndTime: _reservationEndTime.text, 
                        teacherId: currentLoggedInTeacher.uid
                      );
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Success',
                        desc: 'Room has been successfully reserved!',
                        //btnCancelOnPress: () {},
                        btnOkOnPress: () {Navigator.pop(context);},
                      ).show();
                    } else {
                      print("Room is currently occupied at that time");
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'ERROR',
                        desc: 'Error in Email or Password',
                        btnCancelOnPress: () {Navigator.pop(context);},
                        btnOkOnPress: () {Navigator.pop(context);},
                      ).show();
                    }
                  } else{
                    print("Error");
                    Navigator.pop(context);
                  }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 23, 31, 119),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                //fixedSize: Size(MediaQuery.of(context).size.width - 280, 45.0), // Set desired height
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit_calendar_outlined,
                    color: Colors.white,
                    size: 20.0,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Reserve",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
                        ),
            ),
          ],
      ),
    )
  );}
    Future<void> addNewReservation({
    required String reservationLocation,
    required String reservationDate,
    required String reservationStartTime,
    required String reservationEndTime,
    required String teacherId,
  }) async {
    final db = FirebaseFirestore.instance;

    // Create a reference to the new document with auto-generated ID
    final newReservationRef = await db.collection("reservation").add({});

    // Get the auto-generated ID from the reference
    final String reservationId = newReservationRef.id;
    //Turn string date to Timestamp
    Timestamp reservationDateT = stringToTimestamp(reservationDate);
    // Prepare reservation data with reportId
    final reservationData = {
      "reservationLocation": reservationLocation,
      "reservationStatus": "Upcoming",
      "reservationDate": reservationDateT,
      "reservationStartTime": reservationStartTime,
      "reservationEndTime": reservationEndTime,
      "teacherId": teacherId,
      "reservationId": reservationId,
    };

    // Set the data on the document
    await newReservationRef.set(reservationData);

    print("New reservation added with ID: $reservationId");
  }

  Timestamp stringToTimestamp(String date) {
    print(date);
    print(convertDateFormat(date));
    DateTime formatedDate = DateTime.parse(convertDateFormat(date));
    // Get the timestamp
    final Timestamp reservationDate = Timestamp.fromDate(formatedDate);
    return reservationDate;
  }

  String convertDateFormat(String oldDateString) {
    // Split the string into day, month, and year components
    List<String> parts = oldDateString.split('-');

    // Ensure parts array has at least 3 elements (day, month, year)
    if (parts.length != 3) {
      throw FormatException("Invalid date format: $oldDateString");
    }

    // Extract day, month, and year as strings
    String day = parts[0];
    String month = parts[1];
    String year = parts[2];

    // Build the new string in 'yyyy-MM-dd' format
    return "$year-$month-$day";
  }

  Future<bool> isBookingCollision(Timestamp date, String startTime, String endTime) async {
    try {
      // Convert Timestamp to DateTime
      DateTime dateTimeDate = date.toDate();

      // Query Firestore to check for bookings on the given date
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('reservation')
          .where('reservationDate', isEqualTo: date)
          .get();
      print("MY DATE: $date, STARTTIME: $startTime, ENDTIMEM: $endTime");
      // Check for collision with each booking
      for (DocumentSnapshot bookingSnapshot in querySnapshot.docs) {
        // Extract booking details
        Map<String, dynamic>? bookingData = bookingSnapshot.data() as Map<String, dynamic>?;
        print(bookingData);

        if (bookingData == null) {
          // Skip this booking if data is null
          continue;
        }

        String? bookingStartTime = bookingData['reservationStartTime'] as String?;
        String? bookingEndTime = bookingData['reservationEndTime'] as String?;
        print("$bookingStartTime, $bookingEndTime");

        // Check if the booking is within the same date and start/end times are not null
        if (bookingStartTime == null || bookingEndTime == null) { //|| bookingStartTime.split(' ')[0] != bookingEndTime.split(' ')[0]
          // Skip this booking as it's not on the same date or start/end times are null
          continue;
        }

        // Convert booking start and end times to DateTime objects
        DateTime bookingStart = DateTime.parse("2024-05-05 $bookingStartTime");
        DateTime bookingEnd = DateTime.parse("2024-05-05 $bookingEndTime");
        print("$bookingStart, $bookingEnd");

        // Convert startTime and endTime strings to DateTime objects
        DateTime inputStart = DateTime(dateTimeDate.year, dateTimeDate.month, dateTimeDate.day, int.parse(startTime.split(':')[0]), int.parse(startTime.split(':')[1]));
        DateTime inputEnd = DateTime(dateTimeDate.year, dateTimeDate.month, dateTimeDate.day, int.parse(endTime.split(':')[0]), int.parse(endTime.split(':')[1]));
        //if(inputStart.isAtSameMomentAs(bookingStart) && inputEnd.isAtSameMomentAs(bookingEnd))
        if(inputStart.isAtSameMomentAs(bookingStart) && ( inputEnd.isBefore(bookingEnd)  || inputEnd.isAfter(bookingEnd) || inputEnd.isAtSameMomentAs(bookingEnd) ) )
          return true;
        // Check for collision
        if ((inputStart.isAfter(bookingStart) && inputStart.isBefore(bookingEnd)) ||
            (inputEnd.isAfter(bookingStart) && inputEnd.isBefore(bookingEnd)) ||
            (inputStart.isBefore(bookingStart) && inputEnd.isAfter(bookingEnd))) {
          // Collision detected
          return true;
        }
      }
      // No collision found
      return false;
    } catch (e) {
      // Error occurred during Firestore query
      print('Error checking booking collision: $e');
      return false;
    }
  }
}