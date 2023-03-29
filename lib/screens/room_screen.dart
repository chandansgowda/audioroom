import 'dart:convert';
import 'package:audioroom/services/room_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livekit_client/livekit_client.dart';

import '../models/room.dart';
import '../widgets/participants_container.dart';

class SingleRoomScreen extends StatefulWidget {
  final Room room;
  final EventsListener<RoomEvent> listener;
  final AudioRoom audioRoom;

  const SingleRoomScreen(
    this.room,
    this.listener,
    this.audioRoom, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SingleRoomScreenState();
}

class _SingleRoomScreenState extends State<SingleRoomScreen> {
  EventsListener<RoomEvent> get _listener => widget.listener;
  bool get fastConnection => widget.room.engine.fastConnectOptions != null;

  bool _isMicOn = false;

  final db = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    widget.room.addListener(_onRoomDidUpdate);
    _setUpListeners();
    _sortParticipants();
    WidgetsBindingCompatible.instance?.addPostFrameCallback((_) {
      //TODO: Add post frame callback
      // if (!fastConnection) {
      //   _enableMicrophone();
      // }
    });
  }

  @override
  void dispose() {
    // always dispose listener
    (() async {
      widget.room.removeListener(_onRoomDidUpdate);
      await _listener.dispose();
      await widget.room.dispose();
      await RoomService.leaveRoom(roomName: widget.audioRoom.name);
    })();
    super.dispose();
  }

  void _setUpListeners() => _listener
    ..on<RoomDisconnectedEvent>((event) async {
      if (event.reason != null) {
        print('Room disconnected: reason => ${event.reason}');
      }
      WidgetsBindingCompatible.instance
          ?.addPostFrameCallback((timeStamp) => Navigator.pop(context));
    })
    ..on<RoomRecordingStatusChanged>((event) {
      //context.showRecordingStatusChangedDialog(event.activeRecording);
    })
    ..on<LocalTrackPublishedEvent>((_) => _sortParticipants())
    ..on<LocalTrackUnpublishedEvent>((_) => _sortParticipants())
    ..on<DataReceivedEvent>((event) {
      String decoded = 'Failed to decode';
      try {
        decoded = utf8.decode(event.data);
      } catch (_) {
        print('Failed to decode: $_');
      }
      //context.showDataReceivedDialog(decoded);
    });

  void _enableMicrophone() async {
    try {
      await widget.room.localParticipant?.setMicrophoneEnabled(true);
      await db.collection('rooms').doc(widget.audioRoom.name).collection('participants').doc(currentUser!.email).update(
          {"isMicOn": true});
    } catch (error) {
      print('could not enable microphone: $error');
    }
  }

  void _disableMicrophone() async {
    try {
      await widget.room.localParticipant?.setMicrophoneEnabled(false);
      await db.collection('rooms').doc(widget.audioRoom.name).collection('participants').doc(currentUser!.email).update(
          {"isMicOn": false});
    } catch (error) {
      print('could not disable microphone: $error');
    }
  }

  void _onRoomDidUpdate() {
    _sortParticipants();
  }

  void _sortParticipants() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Audio Room",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.amber,
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              RoomService.deleteRoom(roomName: widget.audioRoom.name);
            }, icon: Icon(Icons.delete, color: Colors.black,))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_isMicOn) {
              _disableMicrophone();
            } else {
              _enableMicrophone();
            }
            setState(() {
              _isMicOn = !_isMicOn;
            });
          },
          backgroundColor: (_isMicOn) ? Colors.lightGreenAccent : Colors.redAccent,
          child: Icon((_isMicOn) ? Icons.mic : Icons.mic_off_rounded),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(widget.audioRoom.name, style: GoogleFonts.poppins(fontSize: 30),textAlign: TextAlign.center,),
              Text(widget.audioRoom.description, style: GoogleFonts.poppins(fontSize: 20, color: Colors.grey),textAlign: TextAlign.center,),
              SizedBox(height: 25,),
              ParticipantsContainer(widget.audioRoom.name),
            ],
          ),
        ));
  }
}
