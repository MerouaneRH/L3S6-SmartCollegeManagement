import 'package:flutter/material.dart';

class wilayatfunc extends StatefulWidget {
  TextEditingController search = TextEditingController();

  wilayatfunc({required this.search, super.key});

  @override
  State<wilayatfunc> createState() => _wilayatfuncState();
}

class _wilayatfuncState extends State<wilayatfunc> {
  List wilayasearched = [];
  bool showsearch = false;
  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }

  List<String> algerianWilayat = [
    'Adrar',
    'Chlef',
    'Laghouat',
    'Oum El Bouaghi',
    'Batna',
    'Béjaïa',
    'Biskra',
    'Béchar',
    'Blida',
    'Bouira',
    'Tamanrasset',
    'Tébessa',
    'Tlemcen',
    'Tiaret',
    'Tizi Ouzou',
    'Alger',
    'Djelfa',
    'Jijel',
    'Sétif',
    'Saïda',
    'Skikda',
    'Sidi Bel Abbès',
    'Annaba',
    'Guelma',
    'Constantine',
    'Médéa',
    'Mostaganem',
    'M Sila',
    'Mascara',
    'Ouargla',
    'Oran',
    'El Bayadh',
    'Illizi',
    'Bordj Bou Arréridj',
    'Boumerdès',
    'El Tarf',
    'Tindouf',
    'Tissemsilt',
    'El Oued',
    'Khenchela',
    'Souk Ahras',
    'Tipaza',
    'Mila',
    'Aïn Defla',
    'Naâma',
    'Aïn Témouchent',
    'Ghardaïa',
    'Relizane'
        'Timimoun',
    'Bordj Badji Mokhtar',
    'Ouled Djellal',
    'Béni Abbès',
    'Ain Salah',
    'Ain Guezzam',
    'Touggourt',
    'Djanet',
    'El M Ghair',
    'El Menia',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: widget.search ?? TextEditingController(),
          onChanged: (value) {
            wilayaselect();
          },
          decoration: InputDecoration(
            labelText: 'place',
            hintText: "Enter the name of a wilaya",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Color.fromRGBO(186, 35, 224, 0.067),
              ),
            ),
          ),
          validator: _validateField,
        ),
        if (showsearch)
          Container(
            height: 100,

            // Set a fixed height for the list
            child: ListView.builder(
              itemCount: wilayasearched.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    widget.search.text = wilayasearched[index];
                    setState(() {
                      showsearch = false; // Hide the list after selection
                    });

                    print(widget.search.text);

                    //  Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: ListTile(
                    title: Text(wilayasearched[index]),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  void wilayaselect() {
    if (widget.search.text.trim().isEmpty) {
      wilayasearched = [];
      showsearch = false;
    } else {
      String searchText = widget.search.text.trim().toLowerCase();

      List<String> tempwiyalaysearched = algerianWilayat.where((element) {
        return element.toLowerCase().contains(searchText);
      }).toList();

      wilayasearched = tempwiyalaysearched;
      showsearch = true;
    }

    setState(() {});
  }
}