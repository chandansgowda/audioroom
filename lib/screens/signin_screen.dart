import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'home_screen.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providerConfigs: [
        EmailProviderConfiguration(),
      ],
      showAuthActionSwitch: false,
      headerBuilder: (context, constraints, _) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              "https://www.aossie.org/_next/image?url=%2Flogo1.png&w=640&q=75",
              width: double.infinity,
              fit: BoxFit.fitHeight,
            ),
          ),
        );
      },
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text('Please sign in using the provided credentials.'),
        );
      },
      footerBuilder: (context, action) {
        return Container(
          margin: EdgeInsets.only(top: 20),
            child: OutlinedButton.icon(
                onPressed: () {
                  //Implement Google-Sign-in here
                  Get.snackbar("Coming soon", "This feature is under development.");
                }, icon: Icon(Icons.login),
                label: Text("Sign in With Google")));
      },
      actions: [
        AuthStateChangeAction<SignedIn>((context, _) {
          Get.to(() => HomeScreen());
        }),
      ],
    );
  }
}
