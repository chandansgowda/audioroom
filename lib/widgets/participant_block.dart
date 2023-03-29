import 'package:audioroom/models/participant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (participant.isSpeaker)
                Icon(
                  (participant.isMicOn) ? Icons.mic : Icons.mic_off,
                  color: (participant.isMicOn)
                      ? Colors.lightGreenAccent
                      : Colors.red,
                  size: 18,
                ),
              Text(
                participant.name,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
              ),

            ],
          ),
          Text(getUserRole(), style: GoogleFonts.poppins(color: Colors.grey),)
        ],
      ),
    );
  }
}
