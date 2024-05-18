import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportForm extends StatefulWidget {
  final String roomName;
  const ReportForm({super.key, required this.roomName});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {

  List<Map<String, String>> data = [];

  final _formKey = GlobalKey<FormState>(); // Add form key

  @override
  Widget build(BuildContext context) {

    MultiSelectController<dynamic> reportType = MultiSelectController<dynamic>();
    TextEditingController reportDescription = TextEditingController();

    String? validateReportDescription(String? value) {
      if(value!.isEmpty) return "Description can't be empty";
      return null;
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          height: 420.h,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius:  BorderRadius.circular(30),
            color: const Color.fromRGBO(232, 244, 242, 1),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 0.07),
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
                        const SizedBox(width: 10,),
                        Text(
                          widget.roomName,
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
              const SizedBox(height: 25,),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 0.07),
                  ),       
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 0.07),
                          ),       
                          //color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: 
                        MultiSelectDropDown<dynamic>(
                          fieldBackgroundColor: const Color.fromRGBO(211, 229, 233, 1),
                          selectedOptions: const [ValueItem(label: 'Hardware related issue', value: 'Hardware')],
                          controller: reportType,
                          hint: "Select report type",
                          onOptionSelected: (List<ValueItem> selectedOptions) {},
                          options: const <ValueItem>[
                            ValueItem(label: 'Hardware related issue', value: 'Hardware'),
                            ValueItem(label: 'Software related issue', value: 'Software'),
                          ],
                          selectionType: SelectionType.single,
                          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                          dropdownHeight: 100,
                          optionTextStyle: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                          dropdownBorderRadius: 20,
                          
                          selectedOptionIcon: const Icon(Icons.check_circle), 
                        ),
                      ),      
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        validator: validateReportDescription,
                        controller: reportDescription,
                        maxLines: 3,
                        decoration: const InputDecoration(
                        hintText: "Description",
                        hintStyle: TextStyle(fontFamily: 'Poppins',),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(211, 229, 233, 1),
                      ),
                      ),
                    ),
                  ],
                ),      
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 90, right: 90),
                child: ElevatedButton(
                  // Use ElevatedButton for a raised button
                  //print("${reportType.selectedOptions[0].label} ${reportDescription.text}");
                  onPressed: () async {
                      if (!_formKey.currentState!.validate()) {  
                        //print("Not valid!"); 11 MAY 2024 SEMAINE A
                        //String result = await calculateTimeRemainingForCourse("sunday","10:00","Amphitheatre 1");
                        //Map<String,dynamic> result = await getNextClosestCourse("sunday","11:30","Amphitheatre 1");
                        //List<Map<String, dynamic>> result = await getInProgressCour("sunday", "09:24", "Amphitheatre 1"); //getCurrentStudentTp("sunday","13:30", "G4", true); //getCurrentStudentCour("sunday","08:30");
                        //print(result);
                        return;
                      }
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.topSlide,
                        title: 'Warning',          
                        descTextStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 16),
                        desc: 'Are you sure you want send the report ?',
                        btnCancelOnPress: () {Navigator.pop(context);},
                        btnOkOnPress: () async { await addNewReport(reportLocation: widget.roomName, reportIssueType: reportType.selectedOptions[0].value, reportDescription: reportDescription.text); Navigator.pop(context); }// Mark as solved},
                      ).show();
                      //addNewReport(reportLocation: widget.roomName, reportIssueType: reportType.selectedOptions[0].value, reportDescription: reportDescription.text);
                      //Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 23, 31, 119),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    //fixedSize: Size(MediaQuery.of(context).size.width - 180, 55.0), // Set desired height
                    minimumSize: Size(4.h, 40.0.w),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Submit",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Future<void> addNewReport({
  required String reportLocation,
  required String reportIssueType,
  required String reportDescription,
}) async {
  final db = FirebaseFirestore.instance;

  // Create a reference to the new document with auto-generated ID
  final newReportRef = await db.collection("report").add({});

  // Get the auto-generated ID from the reference
  final String reportId = newReportRef.id;

  // Get the current timestamp
  final Timestamp reportDate = Timestamp.now();

  // Prepare reservation data with reportId
  final reportData = {
    "reportId": reportId,
    "reportLocation": reportLocation,
    "reportDate": reportDate,
    "reportIssueType": reportIssueType,
    "reportDescription": reportDescription,
    "reportIsSolved": false,
    "reportIsInProgress": false,
  };

  // Set the data on the document
  await newReportRef.set(reportData);
  print("DONE");

  print("New report added with ID: $reportId");
}