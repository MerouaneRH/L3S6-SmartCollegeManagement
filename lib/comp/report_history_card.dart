import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mini/report/report.dart' show updateReportStatus;

class report_history extends StatelessWidget {
  final String? reportId;
  final String? reportDate;
  final String? reportIssueType;
  final String? reportLocation;
  final String? reportTime;
  final String? timeSinceReport;
  final String? reportDescription;
  final bool reportIsSolved;
  final bool reportIsInProgress;
  const report_history({
    super.key,
    required this.reportId,
    required this.reportDate,
    required this.reportIssueType,
    required this.reportLocation,
    required this.reportTime,
    required this.timeSinceReport,
    required this.reportDescription,
    required this.reportIsSolved,
    required this.reportIsInProgress,
  });

  @override
  Widget build(BuildContext context) {
    final String reportStatus = 
      reportIsSolved && !reportIsInProgress
        ? 
          "Solved" 
        : 
        !reportIsSolved && !reportIsInProgress
        ? 
          "Unsolved" 
        : 
        !reportIsSolved && reportIsInProgress
        ? 
          "In Progress" 
        : 
          "Error"
      ;
    final Color cardColor = 
      reportIsSolved && !reportIsInProgress
        ? 
          Color.fromRGBO(209, 229, 233, 1)
        :
        !reportIsSolved && !reportIsInProgress
        ? 
          Color.fromRGBO(232, 230, 230, 1)
        : 
          Color.fromRGBO(213, 233, 240, 1)
      ;
    final String cardImage = 
      reportIsSolved && !reportIsInProgress
        ? 
          'images/check3.png'
        :
        !reportIsSolved && !reportIsInProgress
        ? 
          'images/alert9.png'
        : 
          'images/hourglass.png'
      ;
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Card(
          margin: const EdgeInsets.only(bottom: 0, top: 8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                    children: [
                      Container(
                              width: 100,height: 150,
                              //color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.only(left:0,right: 0,bottom: 0,top: 0),
                                child: Image.asset(
                                  '$cardImage',
                                ),
                              ),
                            ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    //color: const Color.fromRGBO(195, 214, 217, 1),
                                    color: const Color.fromRGBO(0, 0, 0, 0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "$reportStatus",
                                    style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'Poppins',)
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                  child: Text(
                                    "$reportDate",
                                      maxLines: 2, // Limit the text to one line
                                    overflow: TextOverflow.ellipsis, // Show ellipsis (...) when text overflows  
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, fontFamily: 'Poppins',color: Color.fromRGBO(72, 82, 98, 1),//color: Colors.blueGrey.shade400
                                    )
                                    ),
                                ),
                              ],
                            ),
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 41,
                                  padding: const EdgeInsets.fromLTRB(0, 10, 5, 5),
                                  //width: 200,height: 40,
                                  //color: Colors.green,
                                  child: Text(
                                    "$reportLocation",
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, fontFamily: 'Poppins',color: Color.fromRGBO(72, 82, 98, 1),)),
                                ),
                                const Spacer(),
                                Container(
                                  height: 41,
                                  padding: const EdgeInsets.fromLTRB(5, 17, 10, 1),
                                  //color: Colors.green,
                                  child: Text(  
                                    "$timeSinceReport",
                        
                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Poppins',color: Color.fromRGBO(72, 82, 98, 1),)),
                                ),
                              ],
                            ),
                            //const SizedBox(height: 15),
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  //width: 300,height: 50,
                                  padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                                  //color: Colors.grey,
                                  child: Text(
                                    "$reportIssueType related issue",
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Poppins',color: Color.fromRGBO(72, 82, 98, 1),),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '$reportDescription',
                              maxLines: 3, // Limit the text to one line
                              overflow: TextOverflow.ellipsis, // Show ellipsis (...) when text overflows
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  !reportIsSolved 
                    ? 
                      Row(
                        mainAxisAlignment: reportIsInProgress? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            // Use ElevatedButton for a raised button
                            onPressed: () async {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.question,
                                  animType: AnimType.topSlide,
                                  title: 'Warning',          
                                  descTextStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 16),
                                  desc: 'Are you sure you want to mark this as Solved?',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () async { await updateReportStatus(reportId!, true, false); }// Mark as solved},
                                ).show();
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Poppins',),
                              backgroundColor: const Color.fromARGB(255, 68, 77, 94),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              minimumSize:  Size(4.h, 40.0.w), // Set desired height
                              //fixedSize: Size(155, 30.0), // Set desired height
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
                                  "Mark as Resolved",
                                  style: TextStyle(fontSize: 10, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          !reportIsInProgress
                          ?
                            ElevatedButton(
                              onPressed: () async {
                                print('Mark as In Progress button pressed!');
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.question,
                                  animType: AnimType.topSlide,
                                  title: 'Warning',          
                                  descTextStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 16),
                                  desc: 'Are you sure you want to mark this as In Progress?',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () async { await updateReportStatus(reportId!, false, true); }// Mark as solved},
                                ).show();
                              },
                              style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Poppins',),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                //minimumSize: const Size(4, 40.0), // Set desired height
                                minimumSize:  Size(4.h, 40.0.w),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.hourglass_top,
                                    color: Color.fromARGB(255, 68, 77, 94),
                                    size: 15.0,
                                  ),
                                  Text(
                                    "Mark as In Progress",
                                    style: TextStyle(fontSize: 10, color: Color.fromARGB(255, 68, 77, 94),),
                                  ),
                                ],
                              ),
                            )
                          :
                            const SizedBox(height: 0,),
                        ],
                      )
                    :
                      const SizedBox(height: 0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
