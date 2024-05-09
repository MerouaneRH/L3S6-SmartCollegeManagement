//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:project_mini/comp/my_textfield.dart';
//import 'package:multi_dropdown/enum/app_enums.dart';
//import 'package:multi_dropdown/models/chip_config.dart';
//import 'package:multi_dropdown/models/network_config.dart';
//import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
//import 'package:multi_dropdown/widgets/hint_text.dart';
//import 'package:multi_dropdown/widgets/selection_chip.dart';
//import 'package:multi_dropdown/widgets/single_selected_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportForm extends StatelessWidget {
  const ReportForm({super.key});

  @override
  Widget build(BuildContext context) {

    MultiSelectController<dynamic> reportType = MultiSelectController<dynamic>();
    TextEditingController reportDescription = TextEditingController();

    return SingleChildScrollView(
      child: Container(
        //width: 200,
        //height: 200,
        height: MediaQuery.of(context).size.height * 0.57,
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(30),
          color: Colors.white,
        ),
      child: Column(
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.st,
              children: [
                SizedBox(width: 150,),
                Text(
                  'Report',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            
            SizedBox(height: 20,),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(0, 0, 0, 0.07),
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
                      SizedBox(width: 10,),
                      Text(
                        'Amphitheatre 2',
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
            SizedBox(height: 25,),
            /*MultiSelectDropDown(
              onOptionSelected: (options) {
                debugPrint(options.toString());
              },
              options: const <ValueItem>[
                ValueItem(label: 'Option 1', value: '1'),
                ValueItem(label: 'Option 2', value: '2'),
                ValueItem(label: 'Option 3', value: '3'),
                ValueItem(label: 'Option 4', value: '4'),
                ValueItem(label: 'Option 5', value: '5'),
                ValueItem(label: 'Option 6', value: '6'),
              ],
              maxItems: 2,
              disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
              selectionType: SelectionType.multi,
              chipConfig: const ChipConfig(wrapType: WrapType.wrap),
              dropdownHeight: 300,
              optionTextStyle: const TextStyle(fontSize: 16),
              selectedOptionIcon: const Icon(Icons.check_circle),
            ),*/
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(0, 0, 0, 0.07),
                ),       
                //color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: 
              MultiSelectDropDown<dynamic>(
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
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(
                controller: reportDescription,
                maxLines: 4,
                decoration: InputDecoration(
                hintText: "Description",
                hintStyle: const TextStyle(fontFamily: 'Poppins',),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(
            // Use ElevatedButton for a raised button
            //print("${reportType.selectedOptions[0].label} ${reportDescription.text}");
            onPressed: () {
                addNewReport(reportLocation: "Amphitheatre 3", reportIssueType: reportType.selectedOptions[0].value, reportDescription: reportDescription.text);
                Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 23, 31, 119),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              fixedSize: Size(MediaQuery.of(context).size.width - 180, 55.0), // Set desired height
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
          ],
      ),
      /*child: IconButton(
        icon: const Icon(Icons.close),

        onPressed: () {
          Navigator.of(context).pop();
        },
      )*/
    )
  );}
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

  //print("New report added with ID: $reportId");
}