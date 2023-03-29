import 'package:audioroom/utils/constants.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtService{
  static String createJwtToken(String roomName, {required bool isAdmin}){
    final jwt = JWT(

      // Payload - TODO: This has to be changed for different functions
      {
        "video": {
          "roomCreate": isAdmin,
          "roomAdmin": isAdmin,
          "roomList": true,
          "canPublish": true,
          "canPublishData": true,
          "canSubscribe": true,
          "room": roomName,
          "roomJoin": true
        }
      },

      issuer: lkApiKey,
      subject: 'chandan@gmail.com' //TODO: change this to current user email

    );

    String token = jwt.sign(SecretKey(lkSecretKey));
    return token;
  }
}