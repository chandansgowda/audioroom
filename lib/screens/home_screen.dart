import 'package:audioroom/screens/profile_screen.dart';
import 'package:audioroom/widgets/create_room_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/room_list_card.dart';

class HomeScreen extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text(
          "Available Rooms",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(onPressed: (){
            Get.to(UserProfileScreen());
          }, icon: Icon(Icons.person))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: 'Enter Room Details',
              titlePadding: EdgeInsets.only(top: 10),
              content: CreateRoomDialog(),
              radius: 10.0);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection('rooms').snapshots(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: snapshot.data!.docs.map((room) {
                  return RoomListCard(
                      roomName: room["name"],
                      roomDescription: room["description"],
                      totalParticipants: room["total_participants"]);
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
