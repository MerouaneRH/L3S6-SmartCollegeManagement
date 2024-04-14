import 'package:project_mini/map/core/models/models.dart';
import 'package:project_mini/map/core/models/models2.dart';
import 'package:project_mini/map/core/viewmodels/floorplan_model.dart';
import 'package:project_mini/map/view/shared/global%20copy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final model = Provider.of<FloorPlanModel>(context);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //crossAxisSpacing: 2.0,
        //mainAxisSpacing: 2.0,
        crossAxisCount: 4,
      ),
      itemCount: 12,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        int currentTile = index + 1;
        List<Light> tileLights =
            model.lights.where((item) => item.tile == currentTile).toList();
        List<TrashBin> tileTrashbins =
            model.trashbins.where((item) => item.tile == currentTile).toList();

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              color: Global.blue, // Grid Axies Color
              child: Image.asset(
                'images/tile_0$currentTile.jpg',
              ),
            ),
            model.isScaled
                ? Stack(
                    children: List.generate(
                      tileLights.length,
                      (idx) {
                        return Transform.translate(
                          offset: Offset(
                            size.width * tileLights[idx].position[0],
                            size.width * tileLights[idx].position[1],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: tileLights[idx].status
                                    ? Colors.greenAccent
                                    : Colors.red,
                                radius: 5.0,
                                child: Center(
                                  child: IconButton(
                                      padding: EdgeInsets
                                          .zero, // magical solution for centering
                                      color: Colors.black,
                                      iconSize: 7,
                                      icon: const Icon(Icons.lightbulb_outline),
                                      onPressed: () {}),
                                  /*Icon(
                                    Icons.lightbulb_outline,
                                    color: Global.blue, // bulbe icon
                                    size: 7, // bulbe size icon
                                  ),*/
                                ),
                              ),
                              Transform(
                                transform: Matrix4.identity()..translate(18.0),
                                child: Text(
                                  // TEXT LED001
                                  tileLights[idx].name,
                                  style: const TextStyle(
                                    fontSize: 6.0,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : CircleAvatar(
                    // BIG CIRCLE BEFORE ZOOM
                    backgroundColor: Global.grey,
                    child: Text(
                      //'${tileLights.length}', tf is length probably how much lights is there?
                      '${tileLights.length}',
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
            model.isScaled
                ? Stack(
                    children: List.generate(
                      tileTrashbins.length,
                      (idx) {
                        return Transform.translate(
                          offset: Offset(
                            size.width * tileTrashbins[idx].position[0],
                            size.width * tileTrashbins[idx].position[1],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: tileTrashbins[idx].status
                                    ? Colors.greenAccent
                                    : Colors.red,
                                radius: 5.0,
                                child: Center(
                                  child: IconButton(
                                      padding: EdgeInsets
                                          .zero, // magical solution for centering
                                      color: Colors.black,
                                      iconSize: 7,
                                      icon:
                                          const Icon(Icons.recycling_outlined),
                                      onPressed: () {
                                        print(
                                            "lulw ${tileTrashbins[idx].name}");
                                      }),
                                ),
                              ),
                              Transform(
                                transform: Matrix4.identity()..translate(18.0),
                                child: Text(
                                  // TEXT LED001
                                  tileTrashbins[idx].name,
                                  style: const TextStyle(
                                    fontSize: 6.0,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : CircleAvatar(
                    // BIG CIRCLE BEFORE ZOOM
                    backgroundColor: Global.grey,
                    child: Text(
                      //'${tileLights.length}', tf is length probably how much lights is there?
                      '${tileTrashbins.length}',
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
