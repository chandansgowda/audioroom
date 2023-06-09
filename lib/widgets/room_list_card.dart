import 'package:audioroom/screens/room_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livekit_client/livekit_client.dart';

import '../models/room.dart';
import '../services/room_service.dart';

class RoomListCard extends StatelessWidget {
  final String roomName;
  final String roomDescription;
  final int totalParticipants;

  RoomListCard(
      {required this.roomName,
      required this.roomDescription,
      required this.totalParticipants});

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        await RoomService.joinRoom(
            roomName: roomName,
            description: roomDescription);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Card(
          color: Colors.amber.withOpacity(0.9),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  roomName,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text(roomDescription, style: GoogleFonts.poppins(
                  fontStyle: FontStyle.italic,
                  color: Colors.black
                ),),
                leading: Icon(
                  Icons.multitrack_audio,
                  color: Colors.black,
                  size: 40,
                ),
                trailing: Text(
                  "$totalParticipants Live",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
