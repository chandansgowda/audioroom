
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:livekit_client/livekit_client.dart';

import '../models/room.dart';
import '../screens/room_screen.dart';
import '../utils/constants.dart';
import 'jwt_service.dart';

class LiveKitService{

  static Future<void> joinLiveKitRoom(AudioRoom audioRoom) async {
    //
    try {

      //create new room
      final room = Room();

      // Create a Listener before connecting
      final listener = room.createListener();

      final lkRoomToken = JwtService.createJwtToken(audioRoom.name);
      // Try to connect to the room
      // This will throw an Exception if it fails for any reason.
      await room.connect(
          lkUri,
          lkRoomToken,
          roomOptions: const RoomOptions(
            adaptiveStream: false,
            dynacast: false,
            defaultVideoPublishOptions: VideoPublishOptions(
              simulcast: false,
            ),
          ),
          fastConnectOptions:FastConnectOptions(
            microphone: const TrackOption(enabled: true),
          )
      );

      print("Navigating to Single Room Screen");
      Get.to(() => SingleRoomScreen(room, listener, audioRoom));

    } catch (error) {
      print('Could not connect $error');
    } finally {
      //We can use this to change state
    }
  }
}