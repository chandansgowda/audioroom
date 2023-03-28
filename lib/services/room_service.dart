import 'package:audioroom/screens/home_screen.dart';
import 'package:audioroom/services/api_service.dart';
import 'package:audioroom/services/livekit_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/room.dart';
import '../screens/room_screen.dart';

class RoomService{
  
  static final db = FirebaseFirestore.instance;
  
  static Future createRoom({required String roomName, required String description}) async{

    //TODO: Uncomment this
    await ApiService.createLkRoom(roomName: roomName, metaData: description);

    print("Creating Room on Firebase Firestore");
    await db.collection('rooms').doc(roomName).set({
      "name": roomName,
      "token": "tokentobechanged",
      "description": description,
      "total_participants": 99
    }
    );

    print("Adding Current User into Participants collection");
    //TODO: Replace document email with current user email
    await db.collection('rooms').doc(roomName).collection('participants').doc('chandan@gmail.com').set({
      "email":"chandan@gmail.com",
      "isAdmin": true,
      "isModerator": true,
      "isSpeaker": true
    });

    print("Creating room class");
    AudioRoom audioRoom = AudioRoom(name: roomName, description: description);

    Get.back(); // To close the Dialog Box

    print("Connecting to LiveKit Room");
    LiveKitService.joinLiveKitRoom(audioRoom);

  }

  static Future deleteRoom({required roomName}) async{

    await ApiService.deleteLkRoom(roomName);

    print("Deleting Room on Firebase Firestore");

    await db.collection('rooms').doc(roomName).delete();

    print("Done");

    Get.off(() => HomeScreen());
  }
}