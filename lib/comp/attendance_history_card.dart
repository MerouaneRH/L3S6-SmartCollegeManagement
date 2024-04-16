import 'package:flutter/material.dart';

class History_Card extends StatelessWidget {
  const History_Card({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
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
                  children: [
                    const Icon(Icons.book),
                    const Text(
                      "cours artificial intillenget",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Container(
                      height: 32,
                      width: MediaQuery.of(context).size.width * 0.19,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          //color: Color.fromARGB(255, 218, 90, 62),
                          color: Color.fromARGB(255, 122, 189, 91),
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(left: 50),
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
