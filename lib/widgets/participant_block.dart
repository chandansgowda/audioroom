import 'package:audioroom/models/participant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ParticipantBlock extends StatelessWidget {
  const ParticipantBlock({
    super.key,
    required this.participant,
  });

  final Participant participant;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      alignment: Alignment.center,
      child: Column(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(participant.dpUrl),radius: 40,),
          Row(
            children: [
              if (participant.isSpeaker)
                Icon(Icons.mic),
              Text(
                participant.name,
                style: const TextStyle(
                    color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
