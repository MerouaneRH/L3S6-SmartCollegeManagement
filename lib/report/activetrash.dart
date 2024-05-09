import 'package:flutter/material.dart';
import 'package:project_mini/comp/active_trash_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class activeTrash extends StatefulWidget {
  final void Function(double, LatLng) onPressedCallback; // Define callback
  const activeTrash({super.key, required this.onPressedCallback});

  @override
  State<activeTrash> createState() => _activeTrashState();
}

class _activeTrashState extends State<activeTrash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F4F1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Active Full Bins",
          style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromRGBO(38, 52, 77, 1)),
        ),
        titleTextStyle: TextStyle(fontFamily: 'Poppins', fontSize: 19),
        titleSpacing: 00.0,
        centerTitle: true,
        //toolbarHeight: 50.0,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              //topLeft: Radius.circular(30),
              //topRight: Radius.circular(30),
          ),
        ),
        elevation: 0.00,
        //backgroundColor: const Color(0xFF568C93),
        backgroundColor: Color.fromRGBO(206, 228, 227, 1), 

      ), //AppBar

      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: getBinDataStream(),
          builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>> data = snapshot.data!;
            if(data.isEmpty)
              return Center(
                child: Text("No active full bins."),
              );
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
              final binData = data[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 15), 
                child: activeTrashCard(
                  trashId: binData['binId'],
                  trashLocation: binData['roomName'], // Access specific properties
                  trashCoor: binData['binCoor'],
                  onPressedCallback: widget.onPressedCallback,//widget.onPressedCallback ?? (){},
                  //activeTrashStatus: activeTrashData['activeTrashStatus'],
                ),
            );}
          );
          }
        }),
    );
  }
}
/*Stream<List<Map<String, dynamic>>> getBinDataStream() {
  return FirebaseFirestore.instance.collection('trashbin').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> rawBinData = doc.data() as Map<String, dynamic>;
      return {
        'binId': rawBinData['binId'] as String,
        'binIsFull': rawBinData['true'] as bool,
        'roomId': rawBinData['roomId'] as String,
      };
    }).toList();
  });
}*/
/*Stream<List<Map<String, dynamic>>> getBinDataStream() {
  return FirebaseFirestore.instance.collection('trashbin').snapshots().asyncMap((snapshot) async {
    List<Map<String, dynamic>> binDataList = [];
    
    for (var doc in snapshot.docs) {
      Map<String, dynamic> rawBinData = doc.data() as Map<String, dynamic>;
      String roomId = rawBinData['roomId'] as String;
      String binId = rawBinData['binId'] as String;
      bool binIsFull = rawBinData['binIsFull'] as bool;

      // Fetch room data using roomId
      DocumentSnapshot roomSnapshot = await FirebaseFirestore.instance.collection('room').doc(roomId).get();
      Map<String, dynamic> roomData = roomSnapshot.data() as Map<String, dynamic>;
      String roomName = roomData['roomName'] as String;

      Map<String, dynamic> binData = {
        'binId': binId,
        'binIsFull': binIsFull,
        //'roomId': roomId,
        'roomName': roomName, // Adding roomName to bin data
      };
      
      binDataList.add(binData);
    }
    
    return binDataList;
  });
}*/
Stream<List<Map<String, dynamic>>> getBinDataStream() {
  return FirebaseFirestore.instance.collection('trashbin').snapshots().asyncMap((snapshot) async {
    List<Map<String, dynamic>> binDataList = [];
    
    for (var doc in snapshot.docs) {
      Map<String, dynamic> rawBinData = doc.data() as Map<String, dynamic>;
      bool binIsFull = rawBinData['binIsFull'] as bool;
      bool binIsPicked = rawBinData['binIsPicked'] as bool;
      GeoPoint binCoor = rawBinData['binCoor'] as GeoPoint;

      if (binIsFull && !binIsPicked) { // Check if binIsFull is true and binIsPicked is false
        String roomId = rawBinData['roomId'] as String;
        String binId = rawBinData['binId'] as String;

        DocumentSnapshot roomSnapshot = await FirebaseFirestore.instance.collection('room').doc(roomId).get();
        Map<String, dynamic> roomData = roomSnapshot.data() as Map<String, dynamic>;
        String roomName = roomData['roomName'] as String;

        Map<String, dynamic> binData = {
          'binId': binId,
          'binIsFull': binIsFull,
          'roomName': roomName,
          'binCoor': LatLng(binCoor.latitude, binCoor.longitude),
        };
        
        binDataList.add(binData);
      }
    }
    
    return binDataList;
  });
}

Future<void> markBinAsPicked(String binId) async {
  try {
    // Get reference to the document
    DocumentReference binRef = FirebaseFirestore.instance.collection('trashbin').doc(binId);

    // Update the document
    await binRef.update({
      'binIsPicked': true,
      'binIsFull': false,
    });
    
    print('Bin marked as picked successfully.');
  } catch (error) {
    print('Error marking bin as picked: $error');
    // Handle error as needed
  }
}