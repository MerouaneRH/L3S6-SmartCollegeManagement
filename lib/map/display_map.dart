import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:project_mini/Schedule/schedule_services.dart';
import 'package:project_mini/map/info_form.dart';
import 'package:project_mini/map/map_services.dart';

//import '../firestore_service.dart';

// ignore: must_be_immutable
class DisplayMap extends StatefulWidget {
  static const String route = '/latlng_to_screen_point';
  final String role;
  LatLng? mapIntitalCenter;
  double? mapZoom;
  DisplayMap({super.key, required this.role,this.mapIntitalCenter, this.mapZoom});

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
  late List<Marker> markersZoomedIn;
  late List<Marker> markersZoomedOut;

  bool _markersLoaded = false;

  @override
  void initState()  {
    super.initState();
    currentZoom = widget.mapZoom ?? 17.6;
    _loadMarkers();
  }

  @override
  void dispose() {
    super.dispose();
    widget.mapZoom = null; // set initialZoom to default value after function callback
    widget.mapIntitalCenter = null; // set initialCenter to default value after function callback
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text(
          "Faculty of Sciences Map",
          style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromRGBO(38, 52, 77, 1)),
        ),
        titleTextStyle: TextStyle(fontFamily: 'Poppins', fontSize: 19),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarOpacity: 0.8,
        elevation: 0.00,
        backgroundColor: Color.fromRGBO(206, 228, 227, 1), 

      ),
      body: _markersLoaded ? _buildMap() : _buildLoading(), // Render map or loading indicator based on marker loading status,
    ); 
  }

  Widget _buildMap() {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: widget.mapIntitalCenter ?? const LatLng(34.89580, -1.34833),
            initialZoom: widget.mapZoom ?? 17.6,
            initialRotation: 12,
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
              print("tapPosition: $latLng");
            },
          ),
          children: [
            openStreetMapTileLayer,
            MarkerLayer(
              markers: currentZoom > 19.7 ? markersZoomedIn : markersZoomedOut,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Container(
      color: Color.fromRGBO(206, 228, 227, 1),
      child: Center(
        child: CircularProgressIndicator(), // You can replace this with your custom loading widget
      ),
    );
  }

  Future<void> _loadMarkers() async {
    List<Marker> trashBinMarkers = [];
    if(widget.role == 'agent' || widget.role == 'technician' || widget.role == 'teacher'){
      final trashBinData = await fetchTrashBinData();
      print('Trash bin data: $trashBinData');
      trashBinMarkers = _buildMarkers(trashBinData);
      print('Built markers: $trashBinMarkers');
    }
    //----------------------------------------------
    final roomData = await fetchRoomData();
    print('room data: $roomData');
    final markersZOut = _buildZoomedOutMarkers(roomData);
    print('Built markers: $markersZOut');
    //----------------------------------------------
    List<Marker> lightMarkers = [];
    if(widget.role == 'agent' || widget.role == 'technician' || widget.role == 'teacher'){
      final lightBulbData = await fetchLightBulbData();
      print('lightbulb data: $lightBulbData');
      lightMarkers = _buildLightMarkers(lightBulbData);
      print('Built markers: $lightMarkers');
    }

    setState(() {
      markersZoomedIn = [];
      markersZoomedOut = [];
      markersZoomedIn = trashBinMarkers;
      markersZoomedIn.addAll(lightMarkers);
      markersZoomedOut = markersZOut;
      _markersLoaded = true;
      //print(markersZoomedIn);
    });
  }

  List<Marker> _buildMarkers(List<Map<String, dynamic>> trashBinData) {
    return trashBinData.map((binData) {
      final binId = binData['binId'] as String;
      final binCoor = binData['binCoor'] as LatLng;
      return Marker(
        width: pointSize,
        rotate: true,
        height: pointSize,
        point: binCoor,
        child: IconButton(
          icon: Icon(Icons.delete_outline, size: 40),
          onPressed: () {
            print('Clicked on bin $binId');
          },
        ),
      );
    }).toList();
  }
  // build zoomed out  map Icons
  List<Marker> _buildZoomedOutMarkers(List<Map<String, dynamic>> roomData) {
    return roomData.map((rData) {
      final rId = rData['roomId'] as String;
      final rName = rData['roomName'] as String;
      final rCoor = rData['roomCoor'] as LatLng;
      return Marker(
        width: pointSize,
        rotate: true,
        height: pointSize,
        point: rCoor,
        child: IconButton(
          icon: Icon(Icons.info_outline_rounded, size: 30),
          onPressed: () async {
            print('Clicked on room $rId');
            List<Map<String, dynamic>> result = await getInProgressCour("sunday", "10:01", rName);
            String timeRemaning = await calculateTimeRemainingForCourse("sunday", "10:01", rName);
            Map<String, dynamic> courUpcoming = await getNextClosestCourse("sunday", "10:01", rName);
            //print(timeRemaning);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  insetPadding: EdgeInsets.zero,
                  child: InfoForm(role: widget.role, roomId: rId, roomName: rName, inProgressCour: result, courTimeRemaning: timeRemaning, courUpcoming: courUpcoming),
                );
              },
            );
          },
        ),
      );
    }).toList();
  }
  // build light map Icons
  List<Marker> _buildLightMarkers(List<Map<String, dynamic>> lightBulbData) {
    return lightBulbData.map((lightData) {
      final lightId = lightData['lightId'] as String;
      final lightCoor = lightData['lightCoor'] as LatLng;
      return Marker(
        width: pointSize,
        rotate: true,
        height: pointSize,
        point: lightCoor,
        child: IconButton(
          icon: Icon(Icons.lightbulb_outline, size: 40),
          onPressed: () {
            print('Clicked on light bulb : $lightId');
          },
        ),
      );
    }).toList();
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  tileProvider: CancellableNetworkTileProvider(),
);

