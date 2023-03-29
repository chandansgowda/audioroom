import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

import '../models/room.dart';
import '../services/room_service.dart';
import '../widgets/participants_container.dart';

class SingleRoomScreen extends StatefulWidget {
  final Room room;
  final EventsListener<RoomEvent> listener;
  final AudioRoom audioRoom;

  const SingleRoomScreen(
      this.room,
      this.listener,
      this.audioRoom,
      {
        Key? key,
      }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SingleRoomScreenState();
}

class _SingleRoomScreenState extends State<SingleRoomScreen> {

  EventsListener<RoomEvent> get _listener => widget.listener;
  bool get fastConnection => widget.room.engine.fastConnectOptions != null;

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    widget.room.addListener(_onRoomDidUpdate);
    _setUpListeners();
    _sortParticipants();
    WidgetsBindingCompatible.instance?.addPostFrameCallback((_) {
      if (!fastConnection) {
        _enableMicrophone();
      }
    });
  }

  @override
  void dispose() {
    // always dispose listener
    (() async {
      widget.room.removeListener(_onRoomDidUpdate);
      await _listener.dispose();
      await widget.room.dispose();
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
    } catch (error) {
      print('could not publish audio: $error');
    }
  }

  void _disableMicrophone() async {
    try {
      await widget.room.localParticipant?.setMicrophoneEnabled(false);
    } catch (error) {
      print('could not disable microphone: $error');
    }
  }

  void _onRoomDidUpdate() {
    _sortParticipants();
  }

  void _sortParticipants() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Room Name",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.amber,
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.mic),),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            ParticipantsContainer(),
            
          ],
        ));
  }
}

