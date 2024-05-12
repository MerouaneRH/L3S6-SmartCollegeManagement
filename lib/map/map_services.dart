import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

// Fetch data from trashbin collection
Future<List<Map<String, dynamic>>> fetchTrashBinData() async {
  try {
    QuerySnapshot trashBinSnapshot = await FirebaseFirestore.instance
        .collection('trashbin')
        .get();

    // An empty List to store the processed data
    final List<Map<String, dynamic>> processedTrashBinData = [];

    // Loop through each report document
    for(final trashBin in trashBinSnapshot.docs) {
      Map<String, dynamic> rawTrashBinData = trashBin.data() as Map<String, dynamic>;
      // Process the raw data
      GeoPoint binCoor = rawTrashBinData['binCoor'] as GeoPoint;
      final processedTrashBinDataEntry = {
        'binId': rawTrashBinData['binId'] as String,
        'roomId': rawTrashBinData['roomId'] as String,
        'binIsFull': rawTrashBinData['binIsFull'] as bool,
        'binIsPicked': rawTrashBinData['binIsPicked'] as bool,
        'binCoor': LatLng(binCoor.latitude, binCoor.longitude),
        
      };
      processedTrashBinData.add(processedTrashBinDataEntry);
    }
    return processedTrashBinData;
    
  } catch (e) {
    print('Error fetching user data: $e');
    return [];
  }
}

// Fetch data from room collection
Future<List<Map<String, dynamic>>> fetchRoomData() async {
  try {
    QuerySnapshot roomSnapshot = await FirebaseFirestore.instance
        .collection('room')
        .get();

    // An empty List to store the processed data
    final List<Map<String, dynamic>> processedRoomData = [];

    // Loop through each report document
    for(final room in roomSnapshot.docs) {
      Map<String, dynamic> rawRoomData = room.data() as Map<String, dynamic>;
      // Process the raw data
      GeoPoint roomCoor = rawRoomData['roomCoor'] as GeoPoint;
      final processedRoomDataEntry = {
        'roomId': rawRoomData['roomId'] as String,
        'roomName': rawRoomData['roomName'] as String,
        'roomDescription': rawRoomData['roomDescription'] as String,
        'roomCoor': LatLng(roomCoor.latitude, roomCoor.longitude),
        
      };
      processedRoomData.add(processedRoomDataEntry);
    }
    return processedRoomData;
    
  } catch (e) {
    print('Error fetching user data: $e');
    return [];
  }
}

// Fetch data from lightbulb collection
Future<List<Map<String, dynamic>>> fetchLightBulbData() async {
  try {
    QuerySnapshot lightBulbSnapshot = await FirebaseFirestore.instance
        .collection('lightbulb')
        .get();

    // An empty List to store the processed data
    final List<Map<String, dynamic>> processedLighBulbData = [];

    // Loop through each report document
    for(final light in lightBulbSnapshot.docs) {
      Map<String, dynamic> rawLightData = light.data() as Map<String, dynamic>;
      // Process the raw data
      GeoPoint lightCoor = rawLightData['lightCoor'] as GeoPoint;
      final processedLightDataEntry = {
        'lightId': rawLightData['lightId'] as String,
        'roomId': rawLightData['roomId'] as String,
        'lightIsOn': rawLightData['lightIsOn'] as bool,
        'lightCoor': LatLng(lightCoor.latitude, lightCoor.longitude),
        
      };
      processedLighBulbData.add(processedLightDataEntry);
    }
    return processedLighBulbData;
    
  } catch (e) {
    print('Error fetching user data: $e');
    return [];
  }
}