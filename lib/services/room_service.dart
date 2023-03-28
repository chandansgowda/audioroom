import 'package:audioroom/screens/home_screen.dart';
import 'package:audioroom/services/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/room.dart';
import '../screens/room_screen.dart';

class RoomService{
  
  static final db = FirebaseFirestore.instance;
  
  static Future createRoom({required String name, required String description}) async{

    //await ApiService.createLkRoom(name: name, metaData: description);

    print("Creating Room on Firebase Firestore");
    await db.collection('rooms').doc(name).set({
      "name": name,
      "token": "tokentobechanged",
      "description": description,
      "total_participants": 99
    }
    );

    print("Creating room class");
    Room room = Room(name: name, description: description);

    Get.back(); // To close the Dialog Box

    print("Navigating to Single Room Screen");
    Get.to(() => SingleRoomScreen(room));
  }

  static Future deleteRoom({required roomName}) async{

    await ApiService.deleteLkRoom(roomName);

    print("Deleting Room on Firebase Firestore");

    await db.collection('rooms').doc(roomName).delete();

    print("Done");

    Get.off(() => HomeScreen());
  }
}