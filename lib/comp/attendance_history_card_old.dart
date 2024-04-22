import 'package:flutter/material.dart';

class History_Card extends StatelessWidget {
  const History_Card({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        child: Card(
          color: const Color(0xFF568C93),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Icon(Icons.calendar_month),
                    Text(
                      "03/March/2024",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(children: [
                       Icon(Icons.book),
                       Text(
                        "cours artificial intillenget",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ]),
                    Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 5,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          //color: Color.fromARGB(255, 218, 90, 62),
                          color:const Color.fromARGB(255, 122, 189, 91),
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(right: 40),
                      child: const Center(
                        child: Text("present",
                            style: TextStyle(color: Colors.white)
                            // "Present"
                            ),
                      ),
                    )
                  ],
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.alarm,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("08:30 - 10:00",
                        style: TextStyle(color: Colors.white)),
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
