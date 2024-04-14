import 'package:flutter/material.dart';

class report_history extends StatelessWidget {
  const report_history({super.key});

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
                        Text("Problem type: Hardware"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.book),
                        const Text("Light switch problem"),
                        ///////
                        Container(
                          margin: const EdgeInsets.only(left: 17),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 56, 219, 214),

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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Text color
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
                        Text("Rport Time: 13:30"),
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
