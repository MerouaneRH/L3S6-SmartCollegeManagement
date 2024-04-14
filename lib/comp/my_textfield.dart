import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String? myHintText;
  final Icon? myIcon;
  final TextEditingController? myController;
  final String? Function(String? value)? myValidator;
  final bool isPassword; // Add a flag to indicate if it's a password field

  const MyTextField({
    super.key,
    this.myHintText,
    this.myController,
    this.myIcon,
    this.myValidator,
    this.isPassword = false, // Default to false (not a password field)
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword; // Initialize based on isPassword flag
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        validator: widget.myValidator,
        controller: widget.myController,
        obscureText: _isObscure &&
            widget.isPassword, // Only obscure if it's a password field
        decoration: InputDecoration(
          hintText: widget.myHintText,
          hintStyle: const TextStyle(),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          prefixIcon: widget.myIcon,
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  child: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              : null, // Hide suffix icon for non-password fields
        ),
      ),
    );
  }
}
