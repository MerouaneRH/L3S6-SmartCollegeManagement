import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.only(bottom: 0, top: 8),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
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
                        Text("03/March/2024"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.book),
                        const Text("cours artificial intillenget"),
                        Container(
                          height: 20,
                          width: 75,
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              color: const Color.fromARGB(255, 219, 56, 56),
                              borderRadius: BorderRadius.circular(60)),
                          margin: const EdgeInsets.only(left: 45),
                          child: const Center(
                            child: Text(
                              "Reserved",
                              // "Present"
                            ),
                          ),
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.alarm),
                        Text("08:30 - 10:00"),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.person),
                        Text("Mr.ETCHIALI"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 20,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 190, 178, 178),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(25))),
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
