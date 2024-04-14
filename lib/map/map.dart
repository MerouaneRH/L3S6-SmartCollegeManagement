import 'package:flutter/material.dart';
import 'package:project_mini/map/core/viewmodels/floorplan_model.dart';
import 'package:project_mini/map/view/screens/floorplan_screen.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class Map_page extends StatelessWidget {
  const Map_page({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FloorPlanModel>(
            create: (context) => FloorPlanModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FloorPlanScreen(),
      ),
    );
  }
}
