import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future<List<Map<String, dynamic>>> getCurrentStudentCour(String day, String timeNow) async {
  try {
    QuerySnapshot scheduleSnapshot = await FirebaseFirestore.instance
        .collection('schedule')
        .doc(day)
        .collection('cour')
        .get();
    // Convert timeNow to minutes past midnight
    List<String> nowParts = timeNow.split(':');
    int nowMinutes = int.parse(nowParts[0]) * 60 + int.parse(nowParts[1]);

    List<Map<String, dynamic>> currentCourses = [];

    // Iterate through the scheduleSnapshot
    scheduleSnapshot.docs.forEach((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      // Convert courStartTime and courEndTime to minutes past midnight
      List<String> startParts = data['courStartTime'].split(':');
      int startMinutes = int.parse(startParts[0]) * 60 + int.parse(startParts[1]);

      List<String> endParts = data['courEndTime'].split(':');
      int endMinutes = int.parse(endParts[0]) * 60 + int.parse(endParts[1]);

      // Check if timeNow falls within the interval [courStartTime, courEndTime]
      if (startMinutes <= nowMinutes && nowMinutes <= endMinutes) {
        // If so, add the course to the list of currentCourses
        currentCourses.add(data);
      }
    });

    return currentCourses;
  } catch (error) {
    // Handle errors here
    print('Error fetching data: $error');
    return []; // or throw an error
  }
}

Future<List<Map<String, dynamic>>> getCurrentStudentTp(String day, String timeNow, String groupe, bool isWeekA) async {
  try {
    QuerySnapshot scheduleSnapshot = await FirebaseFirestore.instance
        .collection('schedule')
        .doc(day)
        .collection('tp')
        .where('tpGroupe', isEqualTo: groupe)
        .where('weekA', isEqualTo: isWeekA)
        .get();
    // Convert timeNow to minutes past midnight
    List<String> nowParts = timeNow.split(':');
    int nowMinutes = int.parse(nowParts[0]) * 60 + int.parse(nowParts[1]);

    List<Map<String, dynamic>> currentCourses = [];

    // Iterate through the scheduleSnapshot
    scheduleSnapshot.docs.forEach((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      // Convert courStartTime and courEndTime to minutes past midnight
      List<String> startParts = data['tpStartTime'].split(':');
      int startMinutes = int.parse(startParts[0]) * 60 + int.parse(startParts[1]);

      List<String> endParts = data['tpEndTime'].split(':');
      int endMinutes = int.parse(endParts[0]) * 60 + int.parse(endParts[1]);

      // Check if timeNow falls within the interval [courStartTime, courEndTime]
      if (startMinutes <= nowMinutes && nowMinutes <= endMinutes) {
        // If so, add the course to the list of currentCourses
        currentCourses.add(data);
      }
    });

    return currentCourses;
  } catch (error) {
    // Handle errors here
    print('Error fetching data: $error');
    return []; // or throw an error
  }
}

Future<List<Map<String, dynamic>>> getCurrentStudentTd(String day, String timeNow, String groupe) async {
  try {
    QuerySnapshot scheduleSnapshot = await FirebaseFirestore.instance
        .collection('schedule')
        .doc(day)
        .collection('td')
        .where('tdGroupe', isEqualTo: groupe)
        .get();
    // Convert timeNow to minutes past midnight
    List<String> nowParts = timeNow.split(':');
    int nowMinutes = int.parse(nowParts[0]) * 60 + int.parse(nowParts[1]);

    List<Map<String, dynamic>> currentCourses = [];

    // Iterate through the scheduleSnapshot
    scheduleSnapshot.docs.forEach((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      // Convert courStartTime and courEndTime to minutes past midnight
      List<String> startParts = data['tdStartTime'].split(':');
      int startMinutes = int.parse(startParts[0]) * 60 + int.parse(startParts[1]);

      List<String> endParts = data['tdEndTime'].split(':');
      int endMinutes = int.parse(endParts[0]) * 60 + int.parse(endParts[1]);

      // Check if timeNow falls within the interval [courStartTime, courEndTime]
      if (startMinutes <= nowMinutes && nowMinutes <= endMinutes) {
        // If so, add the course to the list of currentCourses
        currentCourses.add(data);
      }
    });

    return currentCourses;
  } catch (error) {
    // Handle errors here
    print('Error fetching data: $error');
    return []; // or throw an error
  }
}

Future<List<Map<String, dynamic>>> getInProgressCour(String day, String timeNow, String room) async {
  try {
    QuerySnapshot scheduleSnapshot = await FirebaseFirestore.instance
        .collection('schedule')
        .doc(day)
        .collection('cour')
        .where('courLocation', isEqualTo: room)
        .get();
    // Convert timeNow to minutes past midnight
    List<String> nowParts = timeNow.split(':');
    int nowMinutes = int.parse(nowParts[0]) * 60 + int.parse(nowParts[1]);

    List<Map<String, dynamic>> currentCourses = [];

    // Iterate through the scheduleSnapshot
    scheduleSnapshot.docs.forEach((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      // Convert courStartTime and courEndTime to minutes past midnight
      List<String> startParts = data['courStartTime'].split(':');
      int startMinutes = int.parse(startParts[0]) * 60 + int.parse(startParts[1]);

      List<String> endParts = data['courEndTime'].split(':');
      int endMinutes = int.parse(endParts[0]) * 60 + int.parse(endParts[1]);

      // Check if timeNow falls within the interval [courStartTime, courEndTime]
      if (startMinutes <= nowMinutes && nowMinutes < endMinutes) {
        // If so, add the course to the list of currentCourses
        currentCourses.add(data);
      }
    });

    return currentCourses;
  } catch (error) {
    // Handle errors here
    print('Error fetching data: $error');
    return []; // or throw an error
  }
}

// WORK
String getTimeNow() {
  DateTime now = DateTime.now();
    // Format time in "h:m" format (hour:minute)
  String formattedTime = DateFormat('HH:mm').format(now);
  return formattedTime;
}
// WORK

String getCurrentDay() {
  // Get current date
  DateTime now = DateTime.now();

  // Format the current date to get the day
  String formattedDay = DateFormat('EEEE').format(now);

  return formattedDay;
}

Future<String> calculateTimeRemainingForCourse(String day, String timeNow, String location) async {
  try {
    // Get the list of current courses for the specified day and time
    List<Map<String, dynamic>> currentCourses = await getInProgressCour(day, timeNow, location);

    if (currentCourses.isEmpty) {
      return "";
    }

    // Extract start and end times of the first course (assuming there's only one course in progress at a location)
    //String courStartTime = currentCourses[0]['courStartTime'];
    String courEndTime = currentCourses[0]['courEndTime'];

    // Parse start and end times without considering the date
    //DateTime startTime = DateFormat('HH:mm').parse(courStartTime);
    DateTime endTime = DateFormat('HH:mm').parse(courEndTime);
    DateTime currentTime = DateFormat('HH:mm').parse(timeNow);

    // Calculate the time remaining in minutes
    Duration remainingDuration = endTime.difference(currentTime);
    int remainingMinutes = remainingDuration.inMinutes;

    // Return the time remaining in minutes
    return '$remainingMinutes min left';
  } catch (error) {
    print('Error calculating time remaining: $error');
    return "Error calculating time remaining";
  }
}

Future<Map<String, dynamic>> getNextClosestCourse(String day, String timeNow, String location) async {
  try {
    // Get the end time of the currently in-progress course
    /*List<Map<String, dynamic>> inProgressCourses = await getInProgressCour(day, timeNow, location);
    if (inProgressCourses.isEmpty) {
      return {}; // No in-progress course found
    }*/
    //String endTimeOfInProgressCourseString = inProgressCourses[0]['courEndTime'];
    //DateTime endTimeOfInProgressCourse = DateFormat('HH:mm').parse(endTimeOfInProgressCourseString);
    DateTime timeNowNotString = DateFormat('HH:mm').parse(timeNow);
    // Fetch the list of scheduled courses for the current day at the same location
    QuerySnapshot scheduleSnapshot = await FirebaseFirestore.instance
        .collection('schedule')
        .doc(day)
        .collection('cour')
        .where('courLocation', isEqualTo: location)
        .get();

    // Filter out courses that have already started and sort them by start time
    List<Map<String, dynamic>> upcomingCourses = [];
    scheduleSnapshot.docs.forEach((DocumentSnapshot document) {
      Map<String, dynamic> courseData = document.data() as Map<String, dynamic>;
      print("HHHAAED$courseData");
      String startTimeString = courseData['courStartTime'];
      // Parse start time string into DateTime object
      DateTime startTime = DateFormat('HH:mm').parse(startTimeString);
      // Compare start time of courses with end time of in-progress course
      //print("STTIME$startTime IS BEFORE$endTimeOfInProgressCourse");
      print("TIMENOW$timeNowNotString IS AFTER$startTime");
      if (timeNowNotString.isBefore(startTime)) { // Corrected comparison here
        upcomingCourses.add(courseData);
      }
    });
    //if(upcomingCourses.length == 1) upcomingCourses= [];
    print("ASZA$upcomingCourses");
    // Sort the upcoming courses based on their start times
    upcomingCourses.sort((a, b) {
      DateTime startTimeA = DateFormat('HH:mm').parse(a['courStartTime']);
      DateTime startTimeB = DateFormat('HH:mm').parse(b['courStartTime']);
      return startTimeA.compareTo(startTimeB);
    });

    // Return the first upcoming course as the next closest course
    if (upcomingCourses.isNotEmpty) {
      return upcomingCourses.first;
    } else {
      return {}; // No upcoming course found
    }
  } catch (error) {
    print('Error fetching next closest course: $error');
    return {}; // Return empty map in case of error
  }
}







