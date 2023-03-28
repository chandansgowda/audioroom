import 'package:audioroom/services/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/room.dart';
import '../screens/room_screen.dart';

class RoomService{
  
  static final db = FirebaseFirestore.instance;
  
  static Future createRoom({required String name, required String description}) async{

    await ApiService.createLkRoom(name: name, metaData: description);

    print("Creating Room on Firebase Firestore");
    await db.collection('spaces').doc("Room Name").set({
      "name": name,
      "token": "tokentobechanges",
      "description": description,
      "total_participants": 99
    }
    );

    print("Creating room class");
    Room room = Room(name: name, description: description);

    print("Navigating to Single Room Screen");
    Get.to(() => SingleRoomScreen(room));
  }
}