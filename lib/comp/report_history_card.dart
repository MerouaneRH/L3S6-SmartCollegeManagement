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
                        Text("Problem type: Hardware",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.book),
                        const Text("Light switch problem",
                            style: TextStyle(color: Colors.white)),
                        ///////
                        Container(
                          margin: const EdgeInsets.only(left: 17),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 137, 176, 175),

                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(60), // Rounded border
                              ),
                              minimumSize: const Size(100, 10), // Button size
                            ),
                            child: const Center(
                              child: Text(
                                'Mark as solved',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Text color
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.alarm),
                        Text("Rport Time: 13:30",
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
                    height: 20,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 190, 178, 178),
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
