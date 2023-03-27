import 'package:audioroom/screens/room_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RoomListCard extends StatelessWidget {
  final String roomName;
  final String roomDescription;
  final int totalParticipants;

  RoomListCard(
      {required this.roomName,
      required this.roomDescription,
      required this.totalParticipants});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(SingleRoomScreen());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Card(
          color: Colors.amber.withOpacity(0.9),
          child: ListTile(
            title: Text(
              roomName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(roomDescription, style: TextStyle(
              fontStyle: FontStyle.italic
            ),),
            leading: Icon(
              Icons.multitrack_audio,
              color: Colors.green,
            ),
            trailing: Text(
              "$totalParticipants Live",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
