import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
 // Replace with the correct import for MultiSelectDropDown

class RoleBasedDropDown extends StatefulWidget {
  final String hint;
  final List<ValueItem> selectedOptions;
   MultiSelectController<dynamic> controller =
      MultiSelectController<dynamic>();
  final List<ValueItem> options;
  final Function(List<ValueItem>) onOptionSelected;

   RoleBasedDropDown({
    required this.hint,
    required this.selectedOptions,
    required this.controller,
    required this.options,
    required this.onOptionSelected,
    Key? key,
  }) : super(key: key);

  @override
  _RoleBasedDropDownState createState() => _RoleBasedDropDownState();
}

class _RoleBasedDropDownState extends State<RoleBasedDropDown> {
  late List<ValueItem> _selectedOptions;

  @override
  void initState() {
    super.initState();
    _selectedOptions = widget.selectedOptions;
  }

  void _handleOptionSelected(List<ValueItem> selectedOptions) {
    setState(() {
      _selectedOptions = selectedOptions;
    });
    widget.onOptionSelected(selectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10),
      child: MultiSelectDropDown<dynamic>(
        borderRadius: 20,
        fieldBackgroundColor: const Color.fromRGBO(211, 229, 233, 1),
        selectedOptions: _selectedOptions,
        controller: widget.controller,
        hint: widget.hint,
        onOptionSelected: _handleOptionSelected,
        options: widget.options,
        selectionType: SelectionType.single,
        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
        dropdownHeight: 100,
        optionTextStyle: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
        dropdownBorderRadius: 20,
        selectedOptionIcon: const Icon(Icons.check_circle),
        clearIcon: null ,
      ),
    );
  }
}
