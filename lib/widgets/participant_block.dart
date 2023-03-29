import 'package:audioroom/models/participant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ParticipantBlock extends StatelessWidget {
  const ParticipantBlock({
    super.key,
    required this.participant,
  });

  final Participant participant;

  String getUserRole(){
    if (participant.isAdmin) return "Admin";
    else if (participant.isModerator) return "Moderator";
    else if (participant.isSpeaker) return "Speaker";
    else return "Listener";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      alignment: Alignment.center,
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.amber,
            child: CircleAvatar(
              backgroundImage: NetworkImage(participant.dpUrl),
              radius: 30,
            ),
          ),
          Row(
            children: [
              if (participant.isSpeaker)
                Icon(
                  (participant.isMicOn) ? Icons.mic : Icons.mic_off,
                  color: (participant.isMicOn)
                      ? Colors.lightGreenAccent
                      : Colors.red,
                ),
              Text(
                participant.name,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),

            ],
          ),
          Text(getUserRole(), style: TextStyle(color: Colors.grey),)
        ],
      ),
    );
  }
}
