import 'package:flutter/material.dart';

class History_Card extends StatelessWidget {
  final String? attendaceDate;
  final String? attendaceStatus;
  final String? attendaceSubject;
  final String? attendaceDuration;
  const History_Card({
    super.key,
    required this.attendaceDate,
    required this.attendaceStatus,
    required this.attendaceSubject,
    required this.attendaceDuration,
  });

  @override
  Widget build(BuildContext context) {
    Color cardColor = attendaceStatus == "Present" ? const Color.fromARGB(255, 209, 229, 232) : const Color.fromRGBO(231, 231, 230, 1);
    Color backgroundStatusColor = attendaceStatus == "Present" ? const Color.fromRGBO(0, 255, 8, 0.08) : const Color.fromRGBO(255, 0, 0, 0.06);
    String imageCard = attendaceStatus == "Present" ? 'images/addUser.png' : 'images/removeUser.png';
    return Center(
      child: SizedBox(
        //width: MediaQuery.of(context).size.width - 20,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          margin: const EdgeInsets.only(bottom: 0, top: 8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),),
          ),
          //color: const Color(0xFF568C93),
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
            children: [
              /*CircleAvatar(
                backgroundImage: AssetImage(
                  'images/profile.png',
                ),
                radius: 50.0,
                backgroundColor: Colors.black,
              ),*/
              Padding(
                padding: EdgeInsets.all(15),
                //flex: 1,
                child:Image.asset(imageCard, height: 70,),
                  /*backgroundImage: AssetImage(
                    'images/addUser.png',
                  ),
                  radius: 50.0,*/
                  //backgroundColor: Colors.black,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Row(
                  children: [
                    //SizedBox(width: 25,),
                    SizedBox(
                      width: 35,
                      child: Image.asset(
                        'images/date2.png',
                        height: 30.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        "$attendaceDate",
                        style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                        ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      decoration: BoxDecoration(
                        color: backgroundStatusColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "$attendaceStatus",
                        style: const TextStyle( fontSize: 13, color: Color.fromRGBO(19, 17, 17, 0.70), fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                      ),
                    ),
                  ],
                ),
                    SizedBox(height: 5,),
                    Row(
                  children: [
                    SizedBox(
                        width: 35,
                        child: Image.asset(
                          'images/book1.png',
                          height: 32.0,
                        ),
                      ),
                    Expanded( // Wrap Text widget with Expanded
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          "$attendaceSubject",
                          maxLines: 2, // Limit the text to one line
                          overflow: TextOverflow.ellipsis, // Show ellipsis (...) when text overflows
                          style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                        ),
                      ),
                    ),       
                  ],
                ),
                    SizedBox(height: 5,),
                    Row(
                  children: [
                    SizedBox(
                      width: 35,
                      child: Image.asset(
                        'images/time1.png',
                        height: 30.0,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        "$attendaceDuration",
                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                      ),
                    ),  
                  ],
                ),
                  ],
                ),
              ),
            ],
          ),
        //),
            /*child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    //SizedBox(width: 25,),
                    SizedBox(
                      width: 35,
                      child: Image.asset(
                        'images/date2.png',
                        height: 30.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        "$attendaceDate",
                        style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                        ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      decoration: BoxDecoration(
                        color: backgroundStatusColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "$attendaceStatus",
                        style: const TextStyle( fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'Poppins',)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    SizedBox(
                        width: 35,
                        child: Image.asset(
                          'images/book1.png',
                          height: 32.0,
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        "$attendaceSubject",
                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                      ),
                    ),       
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      child: Image.asset(
                        'images/time1.png',
                        height: 30.0,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        "$attendaceDuration",
                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w800, fontFamily: 'Poppins',)
                      ),
                    ),  
                  ],
                ),
              ],
            ),*/
          ),
        ),
      ),
    );
  }
}
