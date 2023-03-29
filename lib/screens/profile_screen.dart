import 'package:audioroom/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UserProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My profile"),
          centerTitle: true,
          backgroundColor: Colors.amber,
      ),
      body: ProfileScreen(
        actions: [
          SignedOutAction((context) {
            Get.offAll(()=> SignInPage());
          }),
        ],
        providerConfigs: [
          EmailProviderConfiguration()
        ],
      ),
    );
  }
}