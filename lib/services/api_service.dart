import 'dart:convert';
import 'dart:io';

import 'package:audioroom/services/jwt_service.dart';
import 'package:audioroom/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiService{

  static Future createLkRoom({required String roomName, required String metaData}) async{
    final url = Uri.parse("$lkApiUri/livekit.RoomService/CreateRoom");
    final token = JwtService.createJwtToken(roomName, isAdmin: true,);
    final requestBody = jsonEncode({
      "name": roomName,
      "empty_timeout": 300,
      "max_participants": 100,
      "metadata": metaData
    });
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: requestBody
    );
    print("LiveKit CreateRoom Endpoint Hit. Here is the response\n");
    print(response.body);
  }


  static Future deleteLkRoom(String roomName) async{
    final url = Uri.parse("$lkApiUri/livekit.RoomService/DeleteRoom");
    final token = JwtService.createJwtToken(roomName, isAdmin: true,);
    final requestBody = jsonEncode({"room":roomName});
    var response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody
    );
    print("LiveKit DeleteRoom Endpoint Hit. Here is the response\n");
    print(response.body);
  }

}