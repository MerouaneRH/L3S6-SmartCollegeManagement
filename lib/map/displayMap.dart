// ignore_for_file: file_names, depend_on_referenced_packages



import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';

//import '../firestore_service.dart';

class DisplayMap extends StatefulWidget {
  static const String route = '/latlng_to_screen_point';

  const DisplayMap({super.key});

  @override
  State<DisplayMap> createState() => DisplayMapState();
}

class DisplayMapState extends State<DisplayMap> {
  static const double pointSize = 65;

  final MapController mapController = MapController();

  LatLng? tappedCoords;
  Point<double>? tappedPoint;
  double currentZoom = 17.6;

  // Define lists to hold different types of markers
  List<Marker> markersZoomedIn = [];
  List<Marker> markersZoomedOut = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tap/click to set coordinate')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build the markers based on the current zoom level
    _buildMarkers();

    return SizedBox(
      //height: 400,
      child: Scaffold(
        appBar: AppBar(
        title: const Text(
          "Faculty of Sciences Map",
          style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromRGBO(38, 52, 77, 1)),
        ),
        titleTextStyle: TextStyle(fontFamily: 'Poppins', fontSize: 19),
        titleSpacing: 00.0,
        centerTitle: true,
        //toolbarHeight: 50.0,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          /*borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              //topLeft: Radius.circular(30),
              //topRight: Radius.circular(30),
          ),*/
        ),
        elevation: 0.00,
        //backgroundColor: const Color(0xFF568C93),
        backgroundColor: Color.fromRGBO(206, 228, 227, 1), 

      ), //AppBar
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                // Set the initial center to University of Tlemcen.
                initialCenter: const LatLng(34.89580, -1.34833),
                initialZoom: 17.6, // Adjust zoom level as desired
                initialRotation: 12, // Adjust roation level as desired
                minZoom: 17.6,
                maxZoom: 20,
                onPositionChanged: (MapPosition mapPosition, bool hasGesture) {
                  setState(() {
                    currentZoom = mapPosition.zoom!;
                  });
                },
                maxBounds: LatLngBounds(
                  LatLng(34.894181, -1.346634),
                  LatLng(34.897366, -1.350128),
                ),
                interactionOptions: const InteractionOptions(
                  flags: ~InteractiveFlag.doubleTapZoom,
                ),
                onTap: (tapPosition, latLng) {
                  final point =
                      mapController.camera.latLngToScreenPoint(latLng);
                  setState(() {
                    tappedCoords = latLng;
                    tappedPoint = Point<double>(point.x, point.y);
                  });
                },
              ),
              children: [
                openStreetMapTileLayer,
                MarkerLayer(
                  markers: currentZoom > 19.7
                      ? markersZoomedIn
                      : markersZoomedOut,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to build markers based on current zoom level
  void _buildMarkers() {
    markersZoomedIn = [
      Marker(
        width: pointSize,
        rotate: true,
        height: pointSize,
        point: LatLng(34.896239, -1.34924),
        child: IconButton(
          icon: Icon(Icons.delete_outline),
          iconSize: 30,
          color: Color.fromARGB(255, 93, 94, 80),
          onPressed: () {
            print("Clicked BIN#1");
          },
        ),
      ),
      // Add other markers for zoom above 19.7 as needed
    ];

    markersZoomedOut = [
      Marker(
        width: pointSize,
        rotate: true,
        height: pointSize,
        point: LatLng(34.896266176917555, -1.3491687179443161),
        child: IconButton(
          icon: Icon(Icons.info),
          iconSize: 30,
          color: Color(0x32323232),
          onPressed: () {
            print("Clicked INFO#1");
          },
        ),
      ),
      // Add other markers for zoom below or equal to 19.7 as needed
    ];
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  tileProvider: CancellableNetworkTileProvider(),
);