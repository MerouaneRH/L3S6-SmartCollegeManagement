import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class DeleteUser extends StatefulWidget {
  DeleteUser({super.key});

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController familyName = TextEditingController();

  TextEditingController firstName = TextEditingController();

  MultiSelectController<dynamic>? rolecontroller =
      MultiSelectController<dynamic>();

  List<Map<String, dynamic>> studentData = [];

  String? validatefamilyName(String? value) {
    if (value!.isEmpty) {
      return "familyName can't be empty";
    }
    return null;
  }

  String? validatefirstName(String? value) {
    if (value!.isEmpty) {
      return "firstName can't be empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
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
                  //color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Delete Process",
                        textAlign: TextAlign
                            .center, // Centers text within the Expanded widget
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
                )),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10),
            child: TextFormField(
                validator: validatefamilyName,
                controller: familyName,
                decoration: InputDecoration(
                  labelText: 'Family Name',
                  hintText: "Enter the family name of the user to delete",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(186, 35, 224, 0.067),
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10),
            child: TextFormField(
                validator: validatefirstName,
                controller: firstName,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  hintText: "Enter the first name of the user to delete",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(186, 35, 224, 0.067),
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10),
            child: MultiSelectDropDown<dynamic>(
              borderRadius: 20,
              fieldBackgroundColor: const Color(0xffE6F4F1),
              controller: rolecontroller,
              hint: "Select user role",
              onOptionSelected: (List<ValueItem> selectedOptions) {},
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
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                await fetchUserData(
                    rolecontroller!.selectedOptions[0].value.toString());
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
                  print("predata $studentData");
                  print("after fetchUserData $studentData");
                  //firstName.text = studentData[1]['firstName'];
                  //familyName.text = studentData[1]['familyName'];
                  print("UI Ready to go in and this is the map: $studentData");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: const Color(0xffE6F4F1),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.85,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  child: Column(
                                children: [
                                  Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: Color.fromRGBO(0, 0, 0, 0.07),
                                      ),
                                      //color: Colors.red,
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
                                            "Confirmation",
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
                                  SizedBox(height: 20),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: Color.fromRGBO(0, 0, 0, 0.07),
                                        ),
                                        //color: Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20),
                                          ListTile(
                                            title: Text(
                                              "Fullname : ${studentData[0]['firstname']} ${studentData[0]['familyname']}",
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
                                          SizedBox(height: 10),
                                          ListTile(
                                            title: Text(
                                              studentData[0]['birthday'].isEmpty
                                                  ? "Birthday : EMPTY"
                                                  : "Birth Date : ${studentData[0]['birthday'][0]} ${intToMonthName(int.parse(studentData[0]['birthday'][1]))} ${studentData[0]['birthday'][2]}",
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
                                          SizedBox(height: 10),
                                          ListTile(
                                            title: Text(
                                              studentData[0]['role'] == null
                                                  ? "Role : EMPTY"
                                                  : "Role : ${studentData[0]['role']}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            leading: Icon(
                                              Icons.add_moderator_outlined,
                                              size: 26,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          ListTile(
                                            title: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                studentData[0]['email'] == null
                                                    ? "Email : EMPTY"
                                                    : "Email : ${studentData[0]['email']}",
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
                                          SizedBox(height: 10),
                                          ListTile(
                                            title: Text(
                                              studentData[0]['place'] == null
                                                  ? "Residence : EMPTY"
                                                  : "Residence : ${studentData[0]['place']}",
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
                                          SizedBox(height: 30),
                                          ElevatedButton(
                                            onPressed: () {
                                              familyName.text =
                                                  studentData[0]['familyname'];
                                              firstName.text =
                                                  studentData[0]['firstname'];
                                              print(familyName.text);
                                              print(firstName.text);
                                              print(rolecontroller!
                                                  .selectedOptions[0].value
                                                  .toString());
                                              DeleteUserData(
                                                  familyName.text,
                                                  firstName.text,
                                                  rolecontroller!
                                                      .selectedOptions[0].value
                                                      .toString());
                                              Navigator.of(context).popUntil(
                                                  (route) => route.isFirst);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              minimumSize: Size(250, 60),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50,
                                                      vertical: 10),
                                            ),
                                            child: Text(
                                              "Confirm",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 228, 237, 252),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              )),
                            ),
                          ));
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              ),
              child: Text(
                "Verify Informations",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(38, 52, 77, 1),
                ),
              ))
        ],
      ),
    );
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

  Future<void> fetchUserData(String role) async {
    QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
        .collection(role)
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
      familyName.clear();
      firstName.clear();
    } else {
      print('No user found with the given information.');
    }
  }
}

Future<void> DeleteUserData(
    String Studentfamilyname, String StudentfirstName, String role) async {
  try {
    print("wwww");
    QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
        .collection(role)
        .where("familyname", isEqualTo: Studentfamilyname)
        .where("firstname", isEqualTo: StudentfirstName)
        .get();
    print("before if");
    if (studentSnapshot.docs.isNotEmpty) {
      // Map<String, dynamic> useremail=
      //     studentSnapshot.data() as Map<String, dynamic>;
      DocumentReference userData = studentSnapshot.docs.first.reference;

      print("here : $userData");
      userData.delete();
    }
  } catch (e) {
    print('error in deleting user data');
  }
}
