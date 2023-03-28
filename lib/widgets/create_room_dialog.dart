import 'package:audioroom/services/room_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CreateRoomDialog extends StatefulWidget {
  @override
  State<CreateRoomDialog> createState() => _CreateRoomDialogState();
}

class _CreateRoomDialogState extends State<CreateRoomDialog> {
  TextEditingController nameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return (!_isLoading)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      labelText: 'Room Name',
                      labelStyle: TextStyle(color: Colors.white),
                      hintMaxLines: 1,
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 4.0))),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white),
                      hintMaxLines: 1,
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 4.0))),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () async{
                    setState(() {
                      _isLoading = true;
                    });
                    await RoomService.createRoom(
                        name: nameController.text,
                        description: descriptionController.text);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  child: const Text(
                    'Create Room',
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                )
              ],
            ),
          )
        : Center(
            child: const CircularProgressIndicator(),
          );
  }
}
