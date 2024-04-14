import 'package:project_mini/map/view/shared/global%20copy.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      bottom: const PreferredSize(
        preferredSize: Size.zero,
        child: Column(
          children: <Widget>[
            Text(
              'Floor Plan Screen',
              style: TextStyle(
                color: Global.blue,
                fontWeight: FontWeight.w900,
                fontSize: 16.0,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Global.blue,
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
