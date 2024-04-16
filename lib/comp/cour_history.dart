import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key});

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
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              color: const Color(0xFF568C93),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.calendar_month),
                        Text("03/March/2024",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.book),
                        const Text("cours artificial intillenget",
                            style: TextStyle(color: Colors.white)),
                        Container(
                          height: 32,
                          width: MediaQuery.of(context).size.width * 0.19,
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              color: const Color.fromARGB(255, 157, 119, 119),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(left: 70),
                          child: const Center(
                            child: Text(
                              "Reserved",
                              style: TextStyle(color: Colors.white),

                              // "Present"
                            ),
                          ),
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.alarm),
                        Text("08:30 - 10:00",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.person),
                        Text("Mr.ETCHIALI",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 28,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 153, 192, 202),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "  Room ID : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "N104   ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
