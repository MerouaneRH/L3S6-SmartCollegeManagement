import 'package:flutter/material.dart';
import 'package:project_mini/map/reservationForm.dart';

class InfoForm extends StatelessWidget {
  String? roomId;
  String roomName;
  String? role;
  InfoForm({super.key, this.role, this.roomId, required this.roomName});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.47,
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(30),
          //color: Colors.white,
        ),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 450,
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
                          '$roomName',
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
            if(role == 'teacher')
            ElevatedButton(
            onPressed: () {
                showDialog(
                context: context,
                builder: (BuildContext context) {
                return Dialog(
                  insetPadding: EdgeInsets.zero,
                  child: ReservationForm(roomId: roomId,roomName: roomName),
                );
              },
            );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 23, 31, 119),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              //fixedSize: Size(MediaQuery.of(context).size.width - 180, 55.0), // Set desired height
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit_calendar_rounded,
                  color: Colors.white,
                  size: 20.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Reservation",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          ],
      ),
      /*child: IconButton(
        icon: const Icon(Icons.close),

        onPressed: () {
          Navigator.of(context).pop();
        },
      )*/
    )
      ),
  );}
}