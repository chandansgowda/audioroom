import 'package:flutter/material.dart';

class SingleRoomScreen extends StatelessWidget {
  const SingleRoomScreen({Key? key}) : super(key: key);

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
