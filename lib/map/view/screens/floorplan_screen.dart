import 'package:project_mini/map/view/shared/global%20copy.dart';
import 'package:project_mini/map/view/widgets/appbar_widget.dart';
import 'package:project_mini/map/view/widgets/overlay_widget.dart';
import 'package:project_mini/map/view/widgets/raw_gesture_detector_widget.dart';
import 'package:project_mini/map/view/widgets/reset_button_widget.dart';

import '../../core/viewmodels/floorplan_model.dart';

import '../widgets/grindview_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloorPlanScreen extends StatelessWidget {
  const FloorPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FloorPlanModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBarWidget(),
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          color: Global.white,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const RawGestureDetectorWidget(
                  child: GridViewWidget(),
                ),
                model.hasTouched ? const ResetButtonWidget() : const OverlayWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
