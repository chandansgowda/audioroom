import 'package:audioroom/services/api_service.dart';
import 'package:flutter/material.dart';

class SingleRoomScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Room Name", style: TextStyle(fontWeight: FontWeight.w600),),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
