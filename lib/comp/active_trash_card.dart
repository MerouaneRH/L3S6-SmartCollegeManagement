import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:project_mini/report/activetrash.dart' show markBinAsPicked;

class activeTrashCard extends StatelessWidget {
  final void Function(double, LatLng) onPressedCallback; // Define callback
  final String trashId;
  final String trashLocation;
  final bool trashIsPicked = false;
  final LatLng trashCoor;
  const activeTrashCard({
    super.key,
    required this.trashId,
    required this.trashLocation,
    required this.onPressedCallback, // Add callback parameter
    required this.trashCoor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Card(
          margin: const EdgeInsets.only(bottom: 0, top: 8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          color: const Color.fromRGBO(209, 229, 233, 1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                    children: [
                      Container(
                              width: 100,height: 80,
                              //color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.only(left:0,right: 0,bottom: 0,top: 0),
                                child: Image.asset(
                                  'images/trashBin.png',
                                ),
                              ),
                            ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //const SizedBox(height: 10),
                            Row(
                              children: [
                                Image.asset("images/door.png", height: 40,),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    //color: const Color.fromRGBO(195, 214, 217, 1),
                                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "$trashLocation",
                                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, fontFamily: 'Poppins',color: Color.fromRGBO(72, 82, 98, 1),),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                ),
                              ],
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
                        onPressed: () async {
                          print("Trashbin Picked!");
                          markBinAsPicked(trashId);
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Poppins',),
                          backgroundColor: const Color.fromARGB(255, 68, 77, 94),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          //minimumSize:  Size(4.h, 40.0.w), // Set desired height
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 15.0,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              "Mark as Picked",
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          print("CALLBACK FUNCTION");
                          onPressedCallback(20.6, trashCoor);
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Poppins',),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          //minimumSize: const Size(4, 40.0), // Set desired height
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.map,
                              color: Color.fromARGB(255, 68, 77, 94),
                              size: 15.0,
                            ),
                            Text(
                              "Show on Map",
                              style: TextStyle(fontSize: 10, color: Color.fromARGB(255, 68, 77, 94),),
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
      ),
    );
  }
}
