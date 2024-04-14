import 'package:project_mini/map/core/viewmodels/floorplan_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetButtonWidget extends StatelessWidget {
  const ResetButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FloorPlanModel>(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          //elevation: 10.0,
          //style: Color.blue,
          onPressed: () {
            model.reset();
          },
          child: const Icon(
            Icons.refresh,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
