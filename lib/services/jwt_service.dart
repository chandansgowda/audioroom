import 'package:audioroom/utils/constants.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JwtService{

  static final currentUserEmail = FirebaseAuth.instance.currentUser!.email;

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
      subject: currentUserEmail

    );

    String token = jwt.sign(SecretKey(lkSecretKey));
    return token;
  }
}