import 'package:audioroom/utils/constants.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtService{
  String createJwtToken(){
    final jwt = JWT(

      // Payload - TODO: This has to be changed for different functions
      {
        "video": {
          "roomCreate": true,
          "roomAdmin": true,
          "roomList": true
        }
      },

      issuer: lkApiKey,

    );

    String token = jwt.sign(SecretKey(lkSecretKey));
    return token;
  }
}