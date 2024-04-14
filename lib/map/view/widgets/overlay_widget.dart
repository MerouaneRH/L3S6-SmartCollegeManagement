import 'package:project_mini/map/view/shared/global%20copy.dart';
import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Container(
        color: Global.blue.withOpacity(0.85),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.touch_app,
                color: Colors.white,
                size: 40.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Start by dragging with your fingers',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
