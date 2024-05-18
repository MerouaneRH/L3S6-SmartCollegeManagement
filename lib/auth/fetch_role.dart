import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchRole {
  String? role;
  Future<String?> fetchUserDataa() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      if(user == null) return null;
      DocumentSnapshot studentSnapshot = await FirebaseFirestore.instance
          .collection('student')
          .doc(user.uid)
          .get();
      if (studentSnapshot.exists) {
        Map<String, dynamic> userData =
            studentSnapshot.data() as Map<String, dynamic>;

        role = userData['role'];

        return role; // Exit function after retrieving user data
      }

      DocumentSnapshot teacherSnapshot = await FirebaseFirestore.instance
          .collection('teacher')
          .doc(user.uid)
          .get();

      if (teacherSnapshot.exists) {
        Map<String, dynamic> userData =
            teacherSnapshot.data() as Map<String, dynamic>;

        role = userData['role'];

        return role;
      }

       DocumentSnapshot agentSnapshot = await FirebaseFirestore.instance
          .collection('agent')
          .doc(user.uid)
          .get();

      if (agentSnapshot.exists) {
        Map<String, dynamic> userData =
            agentSnapshot.data() as Map<String, dynamic>;

        role = userData['role'];

        return role;
      }

      DocumentSnapshot AdminSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc(user?.uid)
          .get();
      if (AdminSnapshot.exists) {
        Map<String, dynamic> userData =
            AdminSnapshot.data() as Map<String, dynamic>;

        role = userData['role'];

        return role; // Exit function after retrieving user data
      }

      // If user document not found in both 'student' and 'teacher' collections, check 'technician' collection
      DocumentSnapshot technicianSnapshot = await FirebaseFirestore.instance
          .collection('technician')
          .doc(user.uid)
          .get();

      if (technicianSnapshot.exists) {
        Map<String, dynamic> userData =
            technicianSnapshot.data() as Map<String, dynamic>;

        role = userData['role'];

        return role;
      }
      print(
          'User document not found in Firestore collections for UID: ${user.uid}');
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }
}
