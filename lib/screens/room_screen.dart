import 'package:audioroom/models/room.dart';
import 'package:audioroom/services/api_service.dart';
import 'package:audioroom/services/room_service.dart';
import 'package:flutter/material.dart';

class SingleRoomScreen extends StatelessWidget {
  late final Room room;
  SingleRoomScreen(this.room);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(room.name, style: TextStyle(fontWeight: FontWeight.w600),),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(onPressed: (){
            RoomService.deleteRoom(roomName: room.name);
          }, icon: Icon(Icons.delete, color: Colors.red,))
        ]
      ),
    );
  }
}
