import 'package:flutter/material.dart';

class changedvaluedialoge extends StatefulWidget {
  final String? attribute;
  TextEditingController changedvalue = TextEditingController();
   changedvaluedialoge({  this.attribute ,required this.changedvalue , super.key});

  @override
  State<changedvaluedialoge> createState() => _changedvaluedialogeState();
}

class _changedvaluedialogeState extends State<changedvaluedialoge> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
                  controller: widget.changedvalue,
                  decoration: InputDecoration(
                    labelText: widget.attribute,
                    hintText: "Enter the ${widget.attribute} to change it's value",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(186, 35, 224, 0.067),
                      ),
                    ),
                  )
                  
                  
                  
                  );
                  
            
  
  }
  
}