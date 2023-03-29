import 'package:audioroom/widgets/participant_block.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/participant.dart';

class ParticipantsContainer extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height / 1.5,
      child: StreamBuilder(
          stream: db
              .collection('rooms')
              .doc('AOSSIE Team Meet')
              .collection('participants')
              .snapshots(),
          builder: (ctx, participantSnapshot) {
            if (participantSnapshot.hasError) {
              return const Text('Firestore Connection error');
            }

            var totalParticipants = 0;
            List<DocumentSnapshot> participants;

            if (!participantSnapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              participants = participantSnapshot.data!.docs;
              totalParticipants = participants.length;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 2.5/3,
                ),
                itemCount: totalParticipants,
                itemBuilder: ((context, index) {
                  var participant = participants[index];
                  return FutureBuilder(
                      future: db
                          .collection('users')
                          .doc(participant['email'])
                          .get(),
                      builder: (ctx, userSnapshot) {
                        if (!userSnapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          Participant participantObj = Participant(
                              email: participant["email"],
                              name: userSnapshot.data!["name"],
                              dpUrl: userSnapshot.data!["dpUrl"],
                              isAdmin: participant["isAdmin"],
                              isMicOn: participant["isMicOn"],
                              isModerator: participant["isModerator"],
                              isSpeaker: participant["isSpeaker"],
                              isSpeaking: participant["isSpeaking"]);
                          return ParticipantBlock(participant: participantObj);
                        }
                      });
                }),
              );
            }
          }),
    );
  }
}
