import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Rooms"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('spaces').snapshots(),
        builder: (ctx,snapshot){
          if (!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            return ListView(
              children: snapshot.data!.docs.map((room){
                return Card(
                  child: ListTile(
                    title: Text(room["name"]),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
