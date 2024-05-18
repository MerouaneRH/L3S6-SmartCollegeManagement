import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:project_mini/Admin/wilayat.dart';

class createuser extends StatefulWidget {
  const createuser({super.key});

  @override
  State<createuser> createState() => _createuserState();
}

class _createuserState extends State<createuser> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _familyname = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _group = TextEditingController();
  final TextEditingController _search = TextEditingController();
  final MultiSelectController<dynamic> _newuserrole =
      MultiSelectController<dynamic>();
  final MultiSelectController<dynamic> _grade =
      MultiSelectController<dynamic>();
  List<String> _userbirthday = [];
  String selectedRole = 'student';

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }

  String? validateUserBirthday(String? value) {
    if (value == null || value.isEmpty) {
      return "Date can't be empty";
    }
    return null;
  }

  bool _isPasswordVisible = false;
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    // else if (!RegExp(r'[A-Z]').hasMatch(value)) {
    //   return "Password must contain at least one uppercase letter";
    // }
    //  else if (!RegExp(r'[a-z]').hasMatch(value)) {
    //   return "Password must contain at least one lowercase letter";
    // }
    else if (!RegExp(r'\d').hasMatch(value)) {
      return "Password must contain at least one digit";
    }
    // else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
    //   return "Password must contain at least one special character";
    // }
    return null;
  }

  String? emailValidator(String? value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || !emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  Future<void> createuser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create User in Firebase Authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Create User Document in Firestore
        await FirebaseFirestore.instance
            .collection(_newuserrole.selectedOptions[0].value)
            .doc(userCredential.user!.uid)
            .set({
          'firstname': _firstname.text,
          'familyname': _familyname.text,
          'email': _emailController.text,
          'role': _newuserrole.selectedOptions[0].value,
          'birthday': _userbirthday,
          'place': _search.text,
          if (selectedRole == 'student') 'group': _group.text,
          'grade': _grade.selectedOptions[0].value,
        });

        // Clear text controllers after successful creation
        _firstname.clear();
        _familyname.clear();
        _emailController.clear();
        _passwordController.clear();
        _search.clear();
        _group.clear();
        Navigator.pop(context);

        // Show success message or navigate to next screen
      } catch (e) {
        // Handle errors here
        print('Error creating user: $e');
        // Optionally, show an error message to the user
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text("this email already exist"),
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: TextFormField(
                controller: _firstname,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  hintText: "Enter the first name of the user",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(186, 35, 224, 0.067),
                    ),
                  ),
                ),
                validator: _validateField,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: TextFormField(
                controller: _familyname,
                decoration: InputDecoration(
                  labelText: 'Family Name',
                  hintText: "Enter the family name of the user",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(186, 35, 224, 0.067),
                    ),
                  ),
                ),
                validator: _validateField,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: "Enter the email of the user",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(186, 35, 224, 0.067),
                    ),
                  ),
                ),
                validator: emailValidator,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: "Enter the password of the user",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(186, 35, 224, 0.067),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,
                validator: _validatePassword,
              ),
            ),
            if (selectedRole == "student")
              Column(
                children: [
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _group,
                      decoration: InputDecoration(
                        labelText: 'Group',
                        hintText: "Enter the group name of the user",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(186, 35, 224, 0.067),
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      validator: _validateField,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: wilayatfunc(search: _search),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: DateTimeField(
                format: DateFormat("yyyy-MM-dd"),
                decoration: InputDecoration(
                  labelText: 'Birthday',
                  hintText: "Select the birthday of the user",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                    context: context,
                    initialDate: currentValue ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                },
                onChanged: (selectedDate) {
                  setState(() {
                    if (selectedDate != null) {
                      _userbirthday = [
                        selectedDate.day.toString(),
                        selectedDate.month.toString(),
                        selectedDate.year.toString(),
                      ];
                    }
                  });
                },
                validator: (value) => validateUserBirthday(value?.toString()),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: MultiSelectDropDown<dynamic>(
                borderRadius: 20,
                fieldBackgroundColor: const Color.fromRGBO(211, 229, 233, 1),
                selectedOptions: const [
                  ValueItem(label: 'student', value: 'student')
                ],
                controller: _newuserrole,
                hint: "Select new user role",
                onOptionSelected: (List<ValueItem> selectedOptions) {
                  setState(() {
                    selectedRole = _newuserrole.selectedOptions[0].value;
                  });
                },
                options: const <ValueItem>[
                  ValueItem(label: 'student', value: 'student'),
                  ValueItem(label: 'teacher', value: 'teacher'),
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
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: MultiSelectDropDown<dynamic>(
                borderRadius: 20,
                fieldBackgroundColor: const Color.fromRGBO(211, 229, 233, 1),
                selectedOptions: const [
                  ValueItem(
                      label: 'L3 - Informatique', value: 'L3 - Informatique')
                ],
                controller: _grade,
                hint: "Select grade",
                onOptionSelected: (List<ValueItem> selectedOptions) {},
                options: const <ValueItem>[
                  ValueItem(
                      label: 'Maitre de Conférences A',
                      value: 'Maitre de Conférences A'),
                  ValueItem(
                      label: 'L3 - Informatique', value: 'L3 - Informatique'),
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
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                createuser();
              },
              child: Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
}