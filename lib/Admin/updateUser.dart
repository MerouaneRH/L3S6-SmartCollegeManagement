import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import 'changedvaluedialoge.dart';
import 'wilayat.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> with TickerProviderStateMixin {
  TextEditingController familyName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController newfamilyName = TextEditingController();
  TextEditingController newfirstName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController newsearch = TextEditingController();
  TextEditingController group = TextEditingController();
  String selectedRole = 'student';
  final MultiSelectController<dynamic> updaterole =
      MultiSelectController<dynamic>();
  List<String> newbirthday = [];
  MultiSelectController<dynamic>? roleController =
      MultiSelectController<dynamic>();
  List<Map<String, dynamic>> studentData = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Color.fromRGBO(0, 0, 0, 0.07),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Update User",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(38, 52, 77, 1),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: const Color.fromRGBO(38, 52, 77, 1),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10),
          child: TextFormField(
            controller: familyName,
            decoration: InputDecoration(
              labelText: 'Family Name',
              hintText: "Enter the family name of the user to update",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Color.fromRGBO(186, 35, 224, 0.067),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10),
          child: TextFormField(
            controller: firstName,
            decoration: InputDecoration(
              labelText: 'First Name',
              hintText: "Enter the first name of the user to update",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Color.fromRGBO(186, 35, 224, 0.067),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10),
          child: MultiSelectDropDown<dynamic>(
            borderRadius: 20,
            fieldBackgroundColor: const Color(0xffE6F4F1),
            controller: roleController,
            hint: "Select user role",
            onOptionSelected: (List<ValueItem> selectedOptions) {
              setState(() {
                selectedRole = roleController!.selectedOptions[0].value;
              });
            },
            options: const <ValueItem>[
              ValueItem(label: 'Student', value: 'student'),
              ValueItem(label: 'Teacher', value: 'teacher'),
              ValueItem(label: 'Agent', value: 'agent'),
              ValueItem(label: 'Technician', value: 'technician'),
            ],
            selectionType: SelectionType.single,
            chipConfig: const ChipConfig(wrapType: WrapType.wrap),
            dropdownHeight: 100,
            optionTextStyle:
                const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
            dropdownBorderRadius: 20,
            selectedOptionIcon: const Icon(Icons.check_circle),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
          onPressed: () async {
            await fetchUserData();
            // firstName.text = studentData[0]['firstname'];
            // familyName.text = studentData[0]['familyname'];
            print("UI Ready to go in and this is the map: $studentData");
            if (studentData.isEmpty)
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text("no user found"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: const Color(0xffE6F4F1),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.71,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Color.fromRGBO(0, 0, 0, 0.07),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Select a field to change it",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.54,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Color.fromRGBO(0, 0, 0, 0.07),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    InkWell(
                                      onTap: () {
                                        // nom w prenom
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  Text("Enter The New Value"),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  changedvaluedialoge(
                                                      attribute:
                                                          "First Attribute",
                                                      changedvalue:
                                                          newfamilyName),

                                                  SizedBox(height: 20),

                                                  // Add some spacing between the text fields
                                                  changedvaluedialoge(
                                                      attribute:
                                                          "Second Attribute",
                                                      changedvalue:
                                                          newfirstName),
                                                ],
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      print(
                                                          "${familyName.text} ooooo");
                                                      print(
                                                          "${firstName.text} ooooo");
                                                      await Future.wait([
                                                        editValue(
                                                            familyName.text,
                                                            firstName.text,
                                                            "familyname",
                                                            newValue:
                                                                newfamilyName
                                                                    .text),
                                                        editValue(
                                                            familyName.text,
                                                            firstName.text,
                                                            "firstname",
                                                            newValue:
                                                                newfirstName
                                                                    .text),
                                                      ]);
                                                      Navigator.of(context)
                                                          .popUntil((route) =>
                                                              route.isFirst);
                                                    },
                                                    child: Text("submit"))
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(
                                          "Fullname : ${studentData[0]['familyname']} ${studentData[0]['firstname']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        leading: Icon(
                                          Icons.person,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    InkWell(
                                      //birthday
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Select Birthday'),
                                              content: DateTimeField(
                                                format:
                                                    DateFormat("yyyy-MM-dd"),
                                                decoration: InputDecoration(
                                                  labelText: 'Birthday',
                                                  hintText:
                                                      "Select the birthday of the user",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                onShowPicker:
                                                    (context, currentValue) {
                                                  return showDatePicker(
                                                    context: context,
                                                    initialDate: currentValue ??
                                                        DateTime.now(),
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime.now(),
                                                  );
                                                },
                                                onChanged: (selectedDate) {
                                                  setState(() {
                                                    newbirthday = [
                                                      selectedDate!.day
                                                          .toString(),
                                                      selectedDate.month
                                                          .toString(),
                                                      selectedDate.year
                                                          .toString(),
                                                    ];
                                                  });
                                                },
                                              ),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    // Add your submit logic here
                                                    await editValue(
                                                        familyName.text,
                                                        firstName.text,
                                                        "birthday",
                                                        newBirthdayArray:
                                                            newbirthday);
                                                    Navigator.of(context)
                                                        .popUntil((route) => route
                                                            .isFirst); // Close the dialog
                                                  },
                                                  child: Text('Submit'),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        // await editValue(familyName.text, firstName.text, "birthday",newBirthdayArray: newbirthday);
                                      },

                                      // editValue(studentData[1]['familyName'], studentData[1]['firstName'], studentData[1]['birthday'], studentData[1]['role'], studentData[1]['email'], studentData[1]['place']);

                                      child: ListTile(
                                        title: Text(
                                          "Birthday : ${studentData[0]['birthday'][0]} ${intToMonthName(int.parse(studentData[0]['birthday'][1]))} ${studentData[0]['birthday'][2]}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        leading: Icon(
                                          Icons.calendar_month,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.red, // Set the color to red
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          "Role : ${studentData[0]['role']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors
                                                .white, // Set the text color to white for better visibility
                                          ),
                                        ),
                                        leading: Icon(
                                          Icons.add_moderator_outlined,
                                          size: 26,
                                          color: Colors
                                              .white, // Set the icon color to white for better visibility
                                        ),
                                      ),
                                    ),
                                    if (selectedRole == "student")
                                      InkWell(
                                        onTap: () {
                                          //email
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    Text("Enter The New Value"),
                                                content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      changedvaluedialoge(
                                                          attribute: "group",
                                                          changedvalue: group),
                                                    ]),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        print(group.text);
                                                        await Future.wait([
                                                          editValue(
                                                              familyName.text,
                                                              firstName.text,
                                                              "group",
                                                              newValue:
                                                                  group.text),
                                                        ]);
                                                        Navigator.of(context)
                                                            .popUntil((route) =>
                                                                route.isFirst);
                                                      },
                                                      child: Text("submit"))
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10),
                                            ListTile(
                                              title: Text(
                                                "Group : ${studentData[0]['group']}",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              leading: Icon(
                                                Icons.group,
                                                size: 26,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    SizedBox(height: 10),
                                    InkWell(
                                      onTap: () {
                                        //email

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  Text("Enter The New Value"),
                                              content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    changedvaluedialoge(
                                                        attribute: "Email",
                                                        changedvalue: email),
                                                  ]),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      print(
                                                          "${familyName.text} ooooo");
                                                      print(
                                                          "${firstName.text} ooooo");
                                                      await Future.wait([
                                                        editValue(
                                                            familyName.text,
                                                            firstName.text,
                                                            "email",
                                                            newValue:
                                                                email.text),
                                                      ]);
                                                      Navigator.of(context)
                                                          .popUntil((route) =>
                                                              route.isFirst);
                                                    },
                                                    child: Text("submit"))
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        title: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                            "Email : ${studentData[0]['email']}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        leading: Icon(
                                          Icons.email_outlined,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    InkWell(
                                      onTap: () {
                                        //                                                                        blasa

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: 300,
                                                    height: 160,
                                                    child: wilayatfunc(
                                                        search: newsearch),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          20), // Add some spacing
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      editValue(
                                                          familyName.text,
                                                          firstName.text,
                                                          "place",
                                                          newValue:
                                                              newsearch.text);
                                                      Navigator.of(context)
                                                          .popUntil((route) =>
                                                              route.isFirst);
                                                      // Add your submit logic here
                                                      // For example, you can call a function or perform some action
                                                      // editValue(familyName.text, firstName.text, "place", newValue: newsearch.text);
                                                      print(newsearch.text);
                                                      // Close the dialog
                                                    },
                                                    child: Text('Submit'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(
                                          "Residence : ${studentData[0]['place']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        leading: Icon(
                                          Icons.home_outlined,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(170, 204, 202, 1),
            minimumSize: Size(150, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          ),
          child: Text(
            "Select this User",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromRGBO(38, 52, 77, 1),
            ),
          ),
        )
      ],
    );
  }

  Future<void> fetchUserData() async {
    try {
      // print(familyName.text);
      // print(firstName.text);
      print(roleController!.selectedOptions[0].value);
      QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
          .collection(roleController!.selectedOptions[0].value)
          .where("familyname", isEqualTo: familyName.text)
          .where("firstname", isEqualTo: firstName.text)
          .get();
      if (studentSnapshot.docs.isNotEmpty) {
        // Clear existing data before adding new data
        List<Map<String, dynamic>> studentPredata = [];
        studentSnapshot.docs.forEach((element) {
          studentPredata.add(element.data() as Map<String, dynamic>);
        });
        studentData = studentPredata;
        print("the map in the function : $studentData");
      } else {
        // Handle case where no user is found
        print('No user found with the given information.');
      }
    } catch (e) {
      print('error in fetching user data');
    }
  }

  String intToMonthName(int monthNumber) {
    const List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    if (monthNumber >= 1 && monthNumber <= 12) {
      return monthNames[monthNumber - 1]; // Adjust for 0-based indexing
    } else {
      throw ArgumentError('Invalid month number: $monthNumber');
    }
  }

  Future<void> editValue(String Name, String First, String attributeName,
      {String? newValue, List<String>? newBirthdayArray}) async {
    try {
      // Query Firestore to find the user with matching family name and first name
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(roleController!.selectedOptions[0].value)
          .where("familyname", isEqualTo: Name)
          .where("firstname", isEqualTo: First)
          .get();

      // Iterate over each document found
      querySnapshot.docs.forEach((doc) async {
        // Update the specified attribute for this user, based on which optional attribute is provided
        if (newValue != null) {
          await doc.reference.update({
            attributeName: newValue,
          });
          print('Attribute updated successfully!');
        } else if (newBirthdayArray != null) {
          await doc.reference.update({
            'birthday': newBirthdayArray,
          });
          print('Birthday array updated successfully!');
        } else {
          print('No optional attribute provided to update.');
        }
      });
    } catch (error) {
      print('Failed to update attribute: $error');
    }
  }
}
